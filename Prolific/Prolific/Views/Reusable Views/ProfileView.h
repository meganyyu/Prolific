//
//  ProfileView.h
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileView : UICollectionReusableView

@property (nonatomic, strong) User *user;

@end

NS_ASSUME_NONNULL_END
