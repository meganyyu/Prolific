//
//  User.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "User.h"

@import Firebase;

@implementation User

+ (void)createUserWithUserId:(NSString *)userId withUsername:(NSString *)username {
    FIRFirestore *const db = [FIRFirestore firestore];
    
    // Add a new document with a generated ID
    __block FIRDocumentReference *ref =
        [[db collectionWithPath:@"users"] addDocumentWithData:@{
          @"userId": userId,
          @"username": username,
        } completion:^(NSError * _Nullable error) {
          if (error != nil) {
            NSLog(@"Error adding document: %@", error);
          } else {
            NSLog(@"Document added with ID: %@", ref.documentID);
          }
        }];
}

@end
