//
//  SceneDelegate.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SceneDelegate.h"

@import FirebaseAuth;
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NavigationManager.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    _window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *) scene];
    
    if ([FIRAuth auth].currentUser) {
        NSLog(@"Welcome back, user with email address %@!", [FIRAuth auth].currentUser.email);
        [NavigationManager presentLoggedInScreenWithSceneDelegate:self];
    } else {
        NSLog(@"No user is signed in.");
        [NavigationManager presentLoggedOutScreenWithSceneDelegate:self];
    }
}

@end
