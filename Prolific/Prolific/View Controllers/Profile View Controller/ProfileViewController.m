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

@end
