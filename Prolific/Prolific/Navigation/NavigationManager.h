//
//  NavigationManager.h
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SceneDelegate.h"
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface NavigationManager : NSObject

+ (void)presentLoggedOutScreenWithSceneDelegate:(SceneDelegate *)sceneDelegate;

+ (void)presentLoggedInScreenWithSceneDelegate:(SceneDelegate *)sceneDelegate;

+ (void)presentRegistrationScreenWithNavigationController:(UINavigationController *)navController;

+ (void)presentProjectDetailsViewControllerForProject:(Project *)project navigationController:(UINavigationController *)navController;

+ (void)exitTopViewController:(UINavigationController *)navController;

+ (void)exitToRootViewController:(UINavigationController *)navController;

@end

NS_ASSUME_NONNULL_END
