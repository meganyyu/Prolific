//
//  ProfileViewController.m
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProfileViewController.h"

#import "DAO.h"
#import "UIColor+ProlificColors.h"

static NSString *const kProfileIconId = @"profile-icon";

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DAO *dao;
@property UIImagePickerController *imagePickerVC;
@property (nonatomic, strong) UIView *profileView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIButton *profileImageButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Profile";
    [super setupBackButton];
    
    [self setupImagePicker];
    
    _profileView = [[UIView alloc] init];
    [self.view addSubview:_profileView];
    
    _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kProfileIconId]];
    [_profileView addSubview:_profileImageView];
    
    _profileImageButton = [[UIButton alloc] init];
    _profileImageButton.backgroundColor = [UIColor ProlificPrimaryBlueColor];
    _profileImageButton.titleLabel.textColor = [UIColor whiteColor];
    [_profileImageButton setTitle:@"Click to change profile picture!" forState:normal];
    [_profileImageButton addTarget:self
                              action:@selector(onProfileImageTap:)
                    forControlEvents:UIControlEventTouchUpInside];
    [_profileView addSubview:_profileImageButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // profile view
    _profileView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // profile picture
    CGFloat const imageViewWidth = 0.4 * boundsWidth;
    CGFloat const imageViewHeight = imageViewWidth;
    CGFloat const imageViewX = _profileView.center.x - imageViewWidth / 2.0;
    CGFloat const imageViewY = _profileView.center.y - imageViewHeight / 2.0;
    _profileImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    // profile picture button
    CGFloat const profileImageButtonX = _profileView.center.x - 150;
    CGFloat const profileImageButtonY = boundsHeight - 300;
    _profileImageButton.frame = CGRectMake(profileImageButtonX, profileImageButtonY, 300, 30);
}

- (void)setupImagePicker {
    _imagePickerVC = [UIImagePickerController new];
    _imagePickerVC.delegate = self;
    _imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        _imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

#pragma mark - User actions

- (void)onProfileImageTap:(id)sender {
    NSLog(@"Requested to change profile picture!");
    [self presentViewController:_imagePickerVC
                       animated:YES
                     completion:nil];
}

#pragma mark - Image Controls

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *const editedImage = info[UIImagePickerControllerEditedImage];
    
    [_profileImageView setImage:editedImage];
    
    //TODO: send to Firebase cloud storage
    
    NSLog(@"finished picking an image!");
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}


@end
