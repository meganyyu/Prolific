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
static NSString *const kBadgesKey = @"badges";

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
        _badges = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)initWithId:(NSString *)userId
                dictionary:(NSDictionary *)data
                    badges:(NSMutableDictionary<NSString *, Badge *> *)badges {
    self = [self init];
    
    if (self) {
        if (userId &&
            [self validateRequiredDictionaryData:data] &&
            [badges isKindOfClass:[NSMutableDictionary<NSString *, Badge *> class]]) {
            _userId = userId;
            _username = data[kUsernameKey];
            _email = @""; //FIXME: load with actual email from FIRAuth
            _displayName = data[kDisplayNameKey];
            _karma = [NSDecimalNumber decimalNumberWithDecimal:[data[kKarmaKey] decimalValue]];
            
            if (badges) {
                _badges = [badges mutableCopy];
            }
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
        _badges = [user.badges mutableCopy];
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

- (UserBuilder *)withBadges:(NSMutableDictionary<NSString *, Badge *> *)badges {
    _badges = [badges mutableCopy];
    return self;
}

- (UserBuilder *)updateExistingBadge:(Badge *)badge {
    [_badges setValue:badge forKey:badge.badgeType];
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
