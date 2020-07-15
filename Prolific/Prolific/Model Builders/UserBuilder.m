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
        _userId = @"testUserId";
        _username = @"testUsername";
        _email = @"testUser@gmail.com";
        _displayName = @"Test User";
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
    User *user = [[User alloc] initWithBuilder:self];
    return user;
}

@end
