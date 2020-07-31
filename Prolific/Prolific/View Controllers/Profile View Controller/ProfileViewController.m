//
//  ProfileViewController.m
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProfileViewController.h"

#import "DAO.h"
@import Firebase;
#import "UIColor+ProlificColors.h"
#import "CircularProgressBar.h"

static NSString *const kProfileIconId = @"profile-icon";

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DAO *dao;
@property UIImagePickerController *imagePickerVC;
@property (nonatomic, strong) UIView *profileView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *displayNameLabel;
@property (nonatomic, strong) UILabel *karmaLabel;
@property (nonatomic, strong) CircularProgressBar *uploadProgressBar;

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
    UITapGestureRecognizer *const profileImageTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                                            action:@selector(onProfileImageTap:)];
    [_profileImageView addGestureRecognizer:profileImageTapGestureRecognizer];
    [_profileImageView setUserInteractionEnabled:YES];
    [_profileView addSubview:_profileImageView];
    
    __weak typeof (self) weakSelf = self;
    [_dao getProfileImageforUser:_user completion:^(UIImage *userImage, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (userImage) {
            [self.profileImageView setImage:userImage];
        }
    }];
    
    _usernameLabel = [[UILabel alloc] init];
    _usernameLabel.text = _user.username;
    [_profileView addSubview:_usernameLabel];
    
    _displayNameLabel = [[UILabel alloc] init];
    _displayNameLabel.text = _user.displayName;
    [_profileView addSubview:_displayNameLabel];
    
    _karmaLabel = [[UILabel alloc] init];
    _karmaLabel.text = [_user.karma stringValue];
    [_profileView addSubview:_karmaLabel];
    
    _uploadProgressBar = [[CircularProgressBar alloc] init];
    _uploadProgressBar.hidden = YES;
    [_profileView addSubview:_uploadProgressBar];
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
    CGFloat const imageViewX = 0.1 * boundsWidth;
    CGFloat const imageViewY = 0.2 * boundsHeight;
    _profileImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    // progress bar
    CGFloat const progressBarWidth = 0.8 * imageViewHeight;
    CGFloat const progressBarHeight = progressBarWidth;
    CGFloat const progressBarX = _profileImageView.center.x - progressBarWidth / 2.0;
    CGFloat const progressBarY = _profileImageView.center.y - progressBarHeight / 2.0;
    _uploadProgressBar.frame = CGRectMake(progressBarX, progressBarY, progressBarWidth, progressBarHeight);
    
    // user info labels
    CGFloat const labelX = imageViewX;
    CGFloat const labelWidth = 80;
    CGFloat const labelHeight = 20;
    CGFloat const displayNameLabelY = imageViewY + imageViewHeight + 20;
    _displayNameLabel.frame = CGRectMake(labelX, displayNameLabelY, labelWidth, labelHeight);
    
    CGFloat const usernameLabelY = displayNameLabelY + labelHeight + 8;
    _usernameLabel.frame = CGRectMake(labelX, usernameLabelY, labelWidth, labelHeight);
    
    CGFloat const karmaLabelY = usernameLabelY + labelHeight + 8;
    _karmaLabel.frame = CGRectMake(labelX, karmaLabelY, labelWidth, labelHeight);
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

- (void)onProfileImageTap:(UITapGestureRecognizer *)sender {
    NSLog(@"Requested to change profile picture!");
    [self presentViewController:_imagePickerVC
                       animated:YES
                     completion:nil];
}

#pragma mark - Image Controls

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *const editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *const resizedImage = [self resizeImage:editedImage
                                           withSize:CGSizeMake(300, 300)];
    
    [_profileImageView setImage:resizedImage];
    
    [self uploadImage:resizedImage];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image
                withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Firebase Storage

- (void)uploadImage:(UIImage *)profileImage {
    NSData *const imageData = UIImagePNGRepresentation(profileImage);
    
    __weak typeof (self) weakSelf = self;
    FIRStorageUploadTask *const uploadTask = [_dao uploadProfileImage:imageData forUser:_user completion:^(NSURL *downloadURL, NSError *error) {
        if (error) {
            NSLog(@"Error uploading data: %@", error.localizedDescription);
        }
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusProgress
                      handler:^(FIRStorageTaskSnapshot *snapshot) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        strongSelf.uploadProgressBar.hidden = NO;
        strongSelf.uploadProgressBar.progress = snapshot.progress.fractionCompleted;
        NSLog(@"You are %f complete:", snapshot.progress.fractionCompleted);
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusSuccess
                      handler:^(FIRStorageTaskSnapshot *snapshot) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        strongSelf.uploadProgressBar.hidden = YES;
    }];
    
}

@end
