
#import "DZCDNAction.h"
#import "DZCDNJsonAction.h"
#import "DZCDNImageAction.h"
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

@end

@implementation NSString (MD5)

- (NSString *) MD5Hash {
    
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (int)[self length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
    
}



@end

static NSString* const kLastUpdateDate = @"kLastUpdateDate";

NSString* DZCDNActionKey(NSString* key, NSString* type) {
    return [NSString stringWithFormat:@"DZCDNFiles-%@-%@", key,type];
}

@interface DZCDNAction ()
{
    NSDate* _lastCheckDate;
    NSString* _fileKey;
}
@end

@implementation DZCDNAction
#pragma mark common tools
+(NSString*) CDNLocalCacheFilesPath
{
    static NSString* documentDirectory= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        documentDirectory = [paths objectAtIndex:0] ;
        documentDirectory = [documentDirectory stringByAppendingPathComponent:@"com.tentcent.cdn.files"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        };
    });
	return documentDirectory;
}

+ (DZCDNAction*) CDNActionForFileType:(DZCDNFileType)type
                              WithURL:(NSURL *)url
                        checkDuration:(NSTimeInterval)duration
                           completion:(DZCDNPullDataCompletionBlock)completion
{
    switch (type) {
        case DZCDNFileTypeStructJSON:
            return [[DZCDNJsonAction alloc] initWithURL:url checkDuration:duration completion:completion];
        case DZCDNFileTypeImagePng:
            return nil;
            break;
        case DZCDNFileTypeImage:
            return [[DZCDNImageAction alloc] initWithURL:url checkDuration:duration completion:completion];
        default:
            return [[DZCDNAction alloc] initWithURL:url checkDuration:duration completion:completion];
            break;
    }
}
#pragma mark -


#pragma mark init
- (instancetype) initWithURL:(NSURL *)url
               checkDuration:(NSTimeInterval)duration
                  completion:(DZCDNPullDataCompletionBlock)completion
{
    self = [super init];
    if (!self) {
        return self;
    }
    [self setUrl:url];
    
    _checkDuration = duration;
    _actionCompletionBlock = completion;
    return self;
}


#pragma mark -
- (BOOL) isExistLocalData
{
    NSString* filePaht = self.localFilePath;
    return [[NSFileManager defaultManager] fileExistsAtPath:filePaht];
}

- (NSString*) localFilePath
{
    return [[DZCDNAction CDNLocalCacheFilesPath] stringByAppendingPathComponent:_fileKey];
}

- (void) setUrl:(NSURL *)url
{
    if (_url != url) {
        _url = url;
        _fileKey = [url.absoluteString MD5Hash];
        if (!_fileKey) {
            _fileKey = [url.relativeString MD5Hash];
        }
    }
}

- (NSDate*) lastCheckDate
{
    if (!_lastCheckDate) {
        NSString* key = DZCDNActionKey(_fileKey, kLastUpdateDate);
        NSDate* date =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (date) {
            _lastCheckDate = date;
        } else {
            _lastCheckDate = [NSDate date];
        }
    }
    return _lastCheckDate;
}

- (BOOL) shouldPullData
{
    if (!self.isExistLocalData) {
        return YES;
    }
    NSDate* lastDate = [self lastCheckDate];
    
    if (ABS([lastDate timeIntervalSinceNow]) < _checkDuration) {
        return NO;
    }
    return YES;
}

- (void) setLastCheckDate:(NSDate*)date
{
    NSString* key = DZCDNActionKey(_fileKey, kLastUpdateDate);
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) pullCDNData:(NSError *__autoreleasing*)error
{
    NSMutableURLRequest* requst = [NSMutableURLRequest requestWithURL:_url];
    
    requst.timeoutInterval = 3;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:requst returningResponse:nil error:error];
    if (*error) {
        return NO;
    }
    _data = data;
    return YES;
}

- (id) decodeCDNFileData:(NSData *)data error:(NSError **)error
{
    if (error != NULL) {
        *error = [NSError errorWithDomain:@"com.tencent.cdn" code:-8002 userInfo:@{NSURLLocalizedLabelKey:@"decodeCDNFileData:error 没有实现"}];
    }
    return nil;
}

- (void) sendCompleteBlock:(id)observer error:(NSError*)error
{
    if (_actionCompletionBlock) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            _actionCompletionBlock(observer , error);
        });
    }
}

- (void) main
{
    @autoreleasepool {
        if (![self shouldPullData]) {
            _data = [NSData dataWithContentsOfFile:self.localFilePath];
        } else {
            NSError* error = nil;
            if(![self pullCDNData:&error]) {
                [self sendCompleteBlock:nil error:error];
                return;
            }
        }
        //
        NSError* error = nil;
        id object =[self decodeCDNFileData:_data error:&error];
        if (error) {
            [self sendCompleteBlock:nil  error:error];
            return;
        }
        [_data writeToFile:self.localFilePath atomically:YES];
        [self setLastCheckDate:[NSDate date]];
        [self sendCompleteBlock:object error:error];
    }
}
@end
