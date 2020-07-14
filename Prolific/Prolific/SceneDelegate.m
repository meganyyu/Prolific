//
//  SceneDelegate.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SceneDelegate.h"

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NavigationManager.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    _window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *) scene];
    [NavigationManager presentLoggedOutScreenWithSceneDelegate:self];
}

@end
