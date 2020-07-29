//
//  User.h
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class UserBuilder;

#import "Entity.h"

#import "UserBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : Entity

#pragma mark - Properties

// required (and immutable) attributes
@property (nonatomic, strong, readonly) NSString *userId;

// required (and mutable) attributes
@property (nonatomic, strong, readonly) NSString *username;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *displayName;

#pragma mark - Methods

- (instancetype)initWithBuilder:(UserBuilder *)builder;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
