//
//  MSRequest.h
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SendSuperFunctionWithError(func)  BOOL ret =  [super func:error];\
if (!ret) {\
    return ret;\
}
#define MSRequestOnErrorAndReturn(error) if(error) { \
[self onError:error];\
_lastError = error;\
return NO;\
}

@class MSRequest;
@protocol MSRequestUIDelegate <NSObject>

- (void) request:(MSRequest*)request onError:(NSError*)error;
- (void) request:(MSRequest *)request onSucced:(id)object;

@end
@interface MSRequest : NSObject
{
    NSMutableDictionary* _paramters;
}
@property (nonatomic, strong, readonly) NSDictionary* allParamters;
@property (nonatomic, strong) NSString* method;
@property (nonatomic, weak) id<MSRequestUIDelegate> uidelegate;
@property (nonatomic, strong ,readonly) NSError* lastError;
- (BOOL) addCommonParamters:(NSError**)error;
- (void) onError:(NSError*)error;
- (void) onSuccess:(id)retObject;
- (BOOL) doRequst;

- (BOOL) loadParamters:(NSError* __autoreleasing*)error;
- (void) addParamter:(id)paramter forKey:(NSString*)key;

//
- (void) doUIOnError:(NSError*)error;
- (void) doUIOnSuccced:(id)object;
@end
