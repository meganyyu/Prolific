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

@interface ProfileViewController ()

@property (nonatomic, strong) DAO *dao;
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
    
    _profileView = [[UIView alloc] init];
    [self.view addSubview:_profileView];
    
    _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kProfileIconId]];
    [_profileView addSubview:_profileImageView];
    
    _profileImageButton = [[UIButton alloc] init];
    _profileImageButton.backgroundColor = [UIColor ProlificPrimaryBlueColor];
    _profileImageButton.titleLabel.textColor = [UIColor whiteColor];
    [_profileImageButton setTitle:@"Click to change profile picture!" forState:normal];
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

@end
