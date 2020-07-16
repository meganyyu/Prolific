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
    }
    return self;
}

- (instancetype)createAndSaveUserWithBuilder:(UserBuilder *)builder {
    [self initWithBuilder:builder];
    [User saveUser:self];
    return self;
}

#pragma mark - Firebase

+ (void)saveUser:(User *)user {
    FIRFirestore *const db = [FIRFirestore firestore];
    NSDictionary *const userData = @{
        @"username": user.username,
        @"displayName": user.displayName
    };
    
    [[[db collectionWithPath:@"users"] documentWithPath:user.userId] setData:userData
                                                                       merge:YES
                                                                  completion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error adding document: %@", error);
        } else {
            NSLog(@"Document successfully written with user ID: %@", user.userId);
        }
    }];
}

@end
