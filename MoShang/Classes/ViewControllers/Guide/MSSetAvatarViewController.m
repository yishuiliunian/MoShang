//
//  MSSetAvatarViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSSetAvatarViewController.h"
#import "UIButton+Custom.h"
#import <DZProgramDefines.h>
#import "MSChoceProviceViewController.h"
#import "MSGlobal.h"
#import <RSKImageCropper.h>
#import "MSUploadImageManager.h"
#import "MSAlertPool.h"
@interface MSSetAvatarViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, RSKImageCropViewControllerDelegate, MSUploadImageDelegate>
{
    UIImageView* _guidImageView;
    UIButton* _avatarButton;
}
@end

@implementation MSSetAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    INIT_SUBVIEW(self.view, UIImageView, _guidImageView);
    _avatarButton = [UIButton CommonBlueButtonForTitle:@"设置头像" target:self action:@selector(setAvatar)];
    [self.view addSubview:_avatarButton];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//#ifdef DEBUG
//    [self nextStep];
//#endif
}
- (void) nextStep
{
    MSChoceProviceViewController* vc = [MSChoceProviceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) setAvatar
{
    [self addPhoto];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void) viewWillLayoutSubviews
{
    CGSize imageSize = CGSizeMake(199, 199);
    self.headTitleLabel.frame = CGRectMake(10, 0, CGRectGetViewControllerWidth - 20, 100);
    _guidImageView.frame = CGRectMake(0, CGRectGetMaxY(self.headTitleLabel.frame), imageSize.width, imageSize.height);
    _avatarButton.frame = CGRectMake(10, CGRectGetMaxY(_guidImageView.frame), CGRectGetViewControllerWidth - 20, 44);
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
    [picker dismissViewControllerAnimated:YES completion:^{
        RSKImageCropViewController* cropVC =[[RSKImageCropViewController alloc]initWithImage:image cropMode:RSKImageCropModeCircle];
        cropVC.delegate = self;
        [self.navigationController presentViewController:cropVC animated:YES completion:nil];
    }];
}

- (void) imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void) imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle
{
    
    [self.guideContentViewController.editUserProcess uploadAvatar:croppedImage];
    
    [self.guideContentViewController.editUserProcess.uploadImageManager addUploadImageObserver:self];
    [controller dismissViewControllerAnimated:YES completion:nil];
    MSAlertShowLoading(@"上传中...");
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImageSucceed:(NSString *)key url:(NSString *)url
{
    [self nextStep];
    MSAlertHideLoading;
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImage:(NSString *)key faild:(NSError *)error
{
    MSAlertHideLoading;
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
