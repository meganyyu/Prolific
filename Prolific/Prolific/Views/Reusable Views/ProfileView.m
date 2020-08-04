//
//  ProfileView.m
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProfileView.h"

@import Lottie;
#import "UIColor+ProlificColors.h"

static NSString *const kProfileIconId = @"profile-icon";
static NSString *const kLoadingAnimationId = @"6541-loading";

@interface ProfileView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *backdropView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property UIImagePickerController *imagePickerVC;
@property (nonatomic, strong) UIView *profileView;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *displayNameLabel;
@property (nonatomic, strong) UILabel *karmaLabel;
@property (nonatomic, strong) LOTAnimationView *loadingView;

@end

@implementation ProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _profileView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_profileView];
        
        _backdropView = [[UIView alloc] init];
        _backdropView.backgroundColor = [UIColor ProlificPrimaryBlueColor];
        [_profileView addSubview:_backdropView];
        
        _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kProfileIconId]];
        [_profileImageView setUserInteractionEnabled:YES];
        [_profileView addSubview:_profileImageView];
        
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
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    
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

@end