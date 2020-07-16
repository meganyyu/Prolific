//
//  UserBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "UserBuilder.h"

@implementation UserBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _userId = nil;
        _username = nil;
        _email = nil;
        _displayName = nil;
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
    _email = email;
    return self;
}

- (UserBuilder *)withDisplayName:(NSString *)displayName {
    _displayName = displayName;
    return self;
}

- (User *)build {
    if (_userId && _username && _email && _displayName) {
        User *user = [[User alloc] initWithBuilder:self];
        return user;
    }
    return nil;
}

@end
