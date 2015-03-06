//
//  MSAvarterCollectionViewController.m
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSAvarterCollectionViewController.h"
#import <DZProgramDefines.h>
#import <Haneke.h>

#import "MSPhotoViewCell.h"
#import "MSAddAvarterCell.h"
#import <JTSImageViewController.h>
#import "MSOssManager.h"

DEFINE_NSString(AddPhotoCellIdentifier)
DEFINE_NSString(NomarlPhotoCellIdentifer)

DEFINE_NSString(UploadKeyPrefix)
NSString* MS_UploadKey(NSUInteger index)
{
    return [NSString stringWithFormat:@"%@%lu", kDZUploadKeyPrefix, (unsigned long)index];
}

int MS_IndexFromUploadKey(NSString*key) {
    NSString* index = [key stringByReplacingOccurrencesOfString:kDZUploadKeyPrefix withString:@""];
    return [index intValue];
}

@interface MSAvarterCollectionViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MSOssUploadObserver>
{
    NSMutableArray* _avaters;
    NSMutableSet* _uploadKeys;
}
@end

@implementation MSAvarterCollectionViewController
- (void) dealloc
{
    [MSShareOssManager removeUploadImageObserver:self];
}
- (instancetype) initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (!self) {
        return self;
    }
    _avaters =[NSMutableArray new];
    _uploadKeys = [NSMutableSet new];
    _canAddPhoto = NO;
    return self;
}
- (instancetype) initWithAvarters:(NSArray*)avarters itemSize:(CGSize)size
{
    UICollectionViewFlowLayout* collectionViewLayout = [UICollectionViewFlowLayout new];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewLayout.itemSize = size;
    self = [self initWithCollectionViewLayout:collectionViewLayout];
    if (!self) {
        return self;
    }
    [_avaters addObjectsFromArray:avarters];
    return self;
}

- (void) setCanAddPhoto:(BOOL)canAddPhoto
{
    _canAddPhoto = canAddPhoto && _avaters.count <= 5;
}
- (NSArray*) avarters
{
    return [_avaters copy];
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[MSAddAvarterCell class] forCellWithReuseIdentifier:kDZAddPhotoCellIdentifier];
    [self.collectionView registerClass:[MSPhotoViewCell class] forCellWithReuseIdentifier:kDZNomarlPhotoCellIdentifer];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_canAddPhoto) {
        return _avaters.count + 1;
    } else
    {
        return _avaters.count;
    }
}

#define IS_TheAddPhotoRow(path) [self isTheAddPhotoRowIndexPath:path]
- (BOOL) isTheAddPhotoRowIndexPath:(NSIndexPath*)path
{
    return path.row == _avaters.count;
}
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_TheAddPhotoRow(indexPath)) {
        MSAddAvarterCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDZAddPhotoCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    } else {
        
        MSPhotoViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDZNomarlPhotoCellIdentifer forIndexPath:indexPath];
        cell.isFirst = (indexPath.row == 0);
        cell.backgroundColor = [UIColor redColor];
        id object = [_avaters objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[NSString class]]) {
            [cell.photoImageView hnk_setImageFromURL:[NSURL URLWithString:object]];
        } else if ([object isKindOfClass:[UIImage class]]) {
            cell.photoImageView.image = object;
        }
        return cell;
    }
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_TheAddPhotoRow(indexPath)) {
        [self addPhoto];
    } else {
        UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
        JTSImageInfo* info = [[JTSImageInfo alloc] init];
        info.referenceRect = cell.frame;
        info.referenceView = cell.superview;
        id ob = _avaters[indexPath.row];
        if ([ob isKindOfClass:[NSString class]]) {
            info.imageURL = [NSURL URLWithString:ob];
        } else {
            info.image = ob;
        }
        
        JTSImageViewController* vc = [[JTSImageViewController alloc] initWithImageInfo:info mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
        [vc showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    }
}

INIT_DZ_EXTERN_STRING(DZSelectImageFromCamera, 相机);
INIT_DZ_EXTERN_STRING(DZSelectImageFromScroll, 相册)
- (void) addPhoto
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:DZSelectImageFromCamera, DZSelectImageFromScroll, nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImagePickerController* picker = [UIImagePickerController new];
    
    void(^ShowPicker)() = ^() {
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    };
    if ([buttonTitle isEqualToString:DZSelectImageFromScroll]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ShowPicker();
    } else if ([buttonTitle isEqualToString:DZSelectImageFromCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        ShowPicker();
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    [_avaters addObject:image];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:[_avaters indexOfObject:image] inSection:0]]];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    [MSShareOssManager addUploadImageObserver:self];
    NSString* key = MS_UploadKey([_avaters indexOfObject:image]);
    [[MSOssManager shareManager] uploadImage:image key:key];
    [_uploadKeys addObject:key];
    
}
- (void) uploadImageWithKey:(NSString *)key faild:(NSError *)error
{
    [MSShareOssManager removeUploadImageObserver:self];
    if ([_uploadKeys containsObject:key]) {
        [_uploadKeys removeObject:key];
    }
}

- (void) uploadImageWithKeySucceed:(NSString *)key url:(NSString *)url
{
    [MSShareOssManager removeUploadImageObserver:self];
    
    if ([_uploadKeys containsObject:key]) {
        [_uploadKeys removeObject:key];
        int index = MS_IndexFromUploadKey(key);
        [_avaters replaceObjectAtIndex:index withObject:url];
    }
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
