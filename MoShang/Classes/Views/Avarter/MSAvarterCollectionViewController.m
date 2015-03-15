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
#import "MSGlobal.h"

DEFINE_NSString(AddPhotoCellIdentifier)
DEFINE_NSString(NomarlPhotoCellIdentifer)


const int kMaxUploadImageCount;
@interface MSAvarterCollectionViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MSUploadImageDelegate>
{

}
@end

@implementation MSAvarterCollectionViewController
@synthesize canAddPhoto = _canAddPhoto;
@synthesize photoManager = _photoManager;
- (void) dealloc
{
}
- (instancetype) initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (!self) {
        return self;
    }
  
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
    [self.photoManager setPhotoArray:avarters];
    return self;
}
- (MSPhotoManager*) photoManager
{
    if (!_photoManager) {
        _photoManager = [[MSPhotoManager alloc] init];
        _photoManager.uiDelegate = self;
    }
    return _photoManager;
}
- (void) setPhotos:(NSArray*)array
{
    [self.photoManager setPhotoArray:array];
}
- (void) setCanAddPhoto:(BOOL)canAddPhoto
{
    _canAddPhoto = canAddPhoto;
}

- (BOOL) canAddPhoto
{
   return  _canAddPhoto && self.photoManager.count <= kMaxUploadImageCount;

}

- (NSArray*) avarters
{
    return self.photoManager.photoArray;
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[MSAddAvarterCell class] forCellWithReuseIdentifier:kDZAddPhotoCellIdentifier];
    [self.collectionView registerClass:[MSPhotoViewCell class] forCellWithReuseIdentifier:kDZNomarlPhotoCellIdentifer];
    self.photoManager.uiDelegate = self.collectionView;
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
        return self.photoManager.count + 1;
    } else
    {
        return self.photoManager.count;
    }
}

#define IS_TheAddPhotoRow(path) [self isTheAddPhotoRowIndexPath:path]
- (BOOL) isTheAddPhotoRowIndexPath:(NSIndexPath*)path
{
    return path.row == self.photoManager.count;
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
        id object = [self.photoManager objectAtIndex:indexPath.row];
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
        id ob = [self.photoManager objectAtIndex:indexPath.row];
        if ([ob isKindOfClass:[NSString class]]) {
            info.imageURL = [NSURL URLWithString:ob];
        } else {
            info.image = ob;
        }
        
        JTSImageViewController* vc = [[JTSImageViewController alloc] initWithImageInfo:info mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
        [vc showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    }
}


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
    [self.photoManager addNeedUploadImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
