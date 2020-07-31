//
//  User.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "User.h"

@import FirebaseFirestore;

@implementation User

#pragma mark - Initializer

- (instancetype)initWithBuilder:(UserBuilder *)builder {
    self = [super init];
    if (self) {
        _userId = builder.userId;
        _username = builder.username;
        _email = builder.email;
        _displayName = builder.displayName;
        _karma = builder.karma;
    }
    return self;
}

@end
