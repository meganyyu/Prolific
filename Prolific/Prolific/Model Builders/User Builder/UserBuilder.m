//
//  UserBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "UserBuilder.h"

@import Firebase;

static NSString *const kUsernameKey = @"username";
static NSString *const kDisplayNameKey = @"displayName";
static NSString *const kKarmaKey = @"karma";
static NSString *const kProfileImageRefKey = @"profileImageRef";

@implementation UserBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _userId = nil;
        _username = nil;
        _email = nil;
        _displayName = nil;
        _karma = [NSDecimalNumber one];
    }
    return self;
}

- (instancetype)initWithId:(NSString *)userId dictionary:(NSDictionary *)data {
    self = [self init];
    
    if (self) {
        if (userId &&
            [self validateRequiredDictionaryData:data]) {
            _userId = userId;
            _username = data[kUsernameKey];
            _email = @""; //FIXME: load with actual email from FIRAuth
            _displayName = data[kDisplayNameKey];
            _karma = [NSDecimalNumber decimalNumberWithDecimal:[data[kKarmaKey] decimalValue]];
        }
    }
    return self;
}

- (instancetype)initWithUser:(User *)user {
    self = [self init];
    
    if (self) {
        _userId = user.userId;
        _username = user.username;
        _email = user.email;
        _displayName = user.displayName;
        _karma = user.karma;
    }
    return self;
}

- (UserBuilder *)withId:(NSString *)userId {
    _userId = userId;
    return self;
}

- (UserBuilder *)withUsername:(NSString *)username {
    _username = username;
    return self;
}

- (UserBuilder *)withEmail:(NSString *)email {
    // TODO: add validation to check that email is a valid format
    _email = email;
    return self;
}

- (UserBuilder *)withDisplayName:(NSString *)displayName {
    _displayName = displayName;
    return self;
}

- (UserBuilder *)withKarma:(NSDecimalNumber *)karma {
    _karma = karma;
    return self;
}

- (UserBuilder *)addKarma:(NSDecimalNumber *)additionalKarma {
    _karma = [_karma decimalNumberByAdding:additionalKarma];
    return self;
}

- (User *)build {
    if (_userId && _username && _email && _displayName && _karma) {
        User *user = [[User alloc] initWithBuilder:self];
        return user;
    }
    return nil;
}

#pragma mark - Helper functions

/** Validates that the data passed in through a dictionary is valid. */
- (BOOL)validateRequiredDictionaryData:(NSDictionary *)data {
    return [[data objectForKey:kUsernameKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kDisplayNameKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kKarmaKey] isKindOfClass:[NSNumber class]];
}

@end
