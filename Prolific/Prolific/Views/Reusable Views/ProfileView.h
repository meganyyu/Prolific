//
//  ProfileView.h
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DAO.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProfileViewDelegate

- (void)presentImagePicker:(UIImagePickerController *)imagePickerVC;

- (void)dismissImagePicker;

@end

@interface ProfileView : UIView

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, weak) id<ProfileViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
