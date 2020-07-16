//
//  UserBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class User;

#import "Entity.h"

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserBuilder : EntityBuilder

#pragma mark - Properties

// required (and immutable) attributes
@property (nonatomic, strong) NSString *userId;

// required (and mutable) attributes
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *displayName;

// optional attributes
@property (nonatomic, strong) NSArray *projectsfollowing;

#pragma mark - Methods

- (UserBuilder *)withId:(NSString *)userId;

- (UserBuilder *)withUsername:(NSString *)username;

- (UserBuilder *)withEmail:(NSString *)email;

- (UserBuilder *)withDisplayName:(NSString *)displayName;

- (User *)build;

@end

NS_ASSUME_NONNULL_END
