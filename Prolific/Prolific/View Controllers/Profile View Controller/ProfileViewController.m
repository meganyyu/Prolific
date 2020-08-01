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
@import Lottie;
#import "UIColor+ProlificColors.h"
#import "CircularProgressBar.h"

static NSString *const kProfileIconId = @"profile-icon";
static NSString *const kLoadingAnimationId = @"6541-loading";

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *backdropView;
@property (nonatomic, strong) DAO *dao;
@property UIImagePickerController *imagePickerVC;
@property (nonatomic, strong) UIView *profileView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *displayNameLabel;
@property (nonatomic, strong) UILabel *karmaLabel;
@property (nonatomic, strong) LOTAnimationView *loadingView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Profile";
    [super setupBackButton];
    
    [self setupImagePicker];
    
    _profileView = [[UIView alloc] init];
    [self.view addSubview:_profileView];
    
    _backdropView = [[UIView alloc] init];
    _backdropView.backgroundColor = [UIColor ProlificPrimaryBlueColor];
    [_profileView addSubview:_backdropView];
    
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
    
    _loadingView = [LOTAnimationView animationNamed:kLoadingAnimationId];
    [_profileView addSubview:_loadingView];
    self.loadingView.hidden = YES;
    
    _usernameLabel = [[UILabel alloc] init];
    [_profileView addSubview:_usernameLabel];
    
    _displayNameLabel = [[UILabel alloc] init];
    [_profileView addSubview:_displayNameLabel];
    
    _karmaLabel = [[UILabel alloc] init];
    [_profileView addSubview:_karmaLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // profile view
    _profileView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // background view
    _backdropView.frame = CGRectMake(0, 0, boundsWidth, 0.3 * boundsHeight);
    
    // profile picture
    CGFloat const imageViewWidth = 100;
    CGFloat const imageViewHeight = imageViewWidth;
    CGFloat const imageViewX = _profileView.center.x - imageViewWidth / 2.0;
    CGFloat const imageViewY = _backdropView.bounds.size.height - imageViewHeight / 2.0;
    _profileImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    _profileImageView.layer.borderWidth = 3.0f;
    _profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width / 2.0;
    _profileImageView.clipsToBounds = YES;
    
    // loading view
    _loadingView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    // user info labels
    CGFloat const labelWidth = 200;
    CGFloat const labelHeight = 25;
    CGFloat const labelX = _profileImageView.center.x - labelWidth / 2.0;
    CGFloat const displayNameLabelY = imageViewY + imageViewHeight + 20;
    _displayNameLabel.frame = CGRectMake(labelX, displayNameLabelY, labelWidth, labelHeight);
    _displayNameLabel.text = _user.displayName;
    _displayNameLabel.textAlignment = NSTextAlignmentCenter;
    [_displayNameLabel setFont:[UIFont boldSystemFontOfSize:22]];
    
    CGFloat const usernameLabelY = displayNameLabelY + labelHeight + 8;
    _usernameLabel.frame = CGRectMake(labelX, usernameLabelY, labelWidth, labelHeight);
    _usernameLabel.text = [NSString stringWithFormat:@"@%@", _user.username];
    _usernameLabel.textAlignment = NSTextAlignmentCenter;
    [_usernameLabel setFont:[UIFont systemFontOfSize:14]];
    
    CGFloat const karmaLabelY = usernameLabelY + labelHeight + 20;
    _karmaLabel.frame = CGRectMake(labelX, karmaLabelY, labelWidth, labelHeight);
    _karmaLabel.text = [NSString stringWithFormat:@"Karma: %@", [_user.karma stringValue]];
    _karmaLabel.textAlignment = NSTextAlignmentCenter;
    [_karmaLabel setFont:[UIFont systemFontOfSize:18]];
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
        
        self.loadingView.hidden = NO;
        [self.loadingView play];
        self.loadingView.loopAnimation = true;
        NSLog(@"You are %f complete:", snapshot.progress.fractionCompleted);
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusSuccess
                      handler:^(FIRStorageTaskSnapshot *snapshot) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        self.loadingView.hidden = YES;
    }];
    
}

@end
