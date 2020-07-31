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
@property (nonatomic, strong, readonly) NSDecimalNumber *karma;

#pragma mark - Methods

/** Returns UserBuilder with all fields initialized based on dictionary data, unless data is missing values, in which case it initializes a UserBuilder the same way as init does. */
- (instancetype)initWithId:(NSString *)userId dictionary:(NSDictionary *)data;

/** Returns UserBuilder with all fields initialized as a copy of a User model. */
- (instancetype)initWithUser:(User *)user;

- (UserBuilder *)withId:(NSString *)userId;

- (UserBuilder *)withUsername:(NSString *)username;

- (UserBuilder *)withEmail:(NSString *)email;

- (UserBuilder *)withDisplayName:(NSString *)displayName;

- (UserBuilder *)withKarma:(NSDecimalNumber *)karma;

/** Returns fully built User if UserBuilder has all fields initialized properly. Else returns nil. */
- (User *)build;

@end

NS_ASSUME_NONNULL_END
