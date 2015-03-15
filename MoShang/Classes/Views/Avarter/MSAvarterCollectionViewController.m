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
#import "MSGlobal.h"

DEFINE_NSString(AddPhotoCellIdentifier)
DEFINE_NSString(NomarlPhotoCellIdentifer)

const int kMaxUploadImageCount = 5;

@interface MSAvarterCollectionViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MSUploadImageDelegate>
{
    NSMutableDictionary* _avaterInfos;
    NSMutableSet* _uploadKeys;
    
    NSMutableArray* _allAvaterKeys;
}
@end

@implementation MSAvarterCollectionViewController
@synthesize canAddPhoto = _canAddPhoto;
- (void) dealloc
{
}
- (instancetype) initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (!self) {
        return self;
    }
    _avaterInfos =[NSMutableDictionary new];
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
    
    [self loadArrays:avarters];
    return self;
}
- (void)  loadArrays:(NSArray*)array
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    for (id object in array) {
        if ([object isKindOfClass:[NSString class]]) {
            [dic setObject:object forKey:object];
        }else if ([object isKindOfClass:[UIImage class]]) {
            [dic setObject:object forKey:MSGenRandomUUID()];
        }
    }
    _avaterInfos = dic;
    _allAvaterKeys = [dic.allKeys mutableCopy];
}
- (void) setPhotos:(NSArray*)array
{
    [self loadArrays:array];
    [self.collectionView reloadData];
}
- (void) setCanAddPhoto:(BOOL)canAddPhoto
{
    _canAddPhoto = canAddPhoto;
}

- (BOOL) canAddPhoto
{
   return  _canAddPhoto && _allAvaterKeys.count <= kMaxUploadImageCount;

}

- (NSArray*) avarters
{
    return _allAvaterKeys;
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[MSAddAvarterCell class] forCellWithReuseIdentifier:kDZAddPhotoCellIdentifier];
    [self.collectionView registerClass:[MSPhotoViewCell class] forCellWithReuseIdentifier:kDZNomarlPhotoCellIdentifer];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    _uploadImageManager= [MSUploadImageManager new];
    _uploadImageManager.delegate = self;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self canAddPhoto]) {
        return _allAvaterKeys.count + 1;
    } else
    {
        return _allAvaterKeys.count;
    }
}

#define IS_TheAddPhotoRow(path) [self isTheAddPhotoRowIndexPath:path]
- (BOOL) isTheAddPhotoRowIndexPath:(NSIndexPath*)path
{
    return path.row == _allAvaterKeys.count;
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
        id object = _avaterInfos[[_allAvaterKeys objectAtIndex:indexPath.row]];
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
        id ob = _avaterInfos[_allAvaterKeys[indexPath.row]];
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
    NSString* key = MSGenRandomUUID();
    [_avaterInfos setObject:image forKey:key];
    [_allAvaterKeys addObject:key];
    if (_allAvaterKeys.count < kMaxUploadImageCount) {
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:[_allAvaterKeys indexOfObject:key] inSection:0]]];
    } else {
        [self.collectionView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_uploadImageManager uploadImage:image key:key];
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImageSucceed:(NSString *)key url:(NSString *)url
{
    [_avaterInfos setObject:url forKey:url];
    [_allAvaterKeys replaceObjectAtIndex:[_allAvaterKeys indexOfObject:key] withObject:url];
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImage:(NSString *)key faild:(NSError *)error
{
    
}
@end
