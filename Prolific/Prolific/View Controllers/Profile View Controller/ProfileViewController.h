//
//  ProfileViewController.h
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : ProlificBaseViewController

@property (nonatomic, strong) User *user;

- (instancetype)initWithUser:(User *)user;

- (void)scrollToMenuIndex:(NSInteger)menuIndex;

@end

NS_ASSUME_NONNULL_END
