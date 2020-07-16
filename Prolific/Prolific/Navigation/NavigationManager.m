//
//  NavigationManager.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "NavigationManager.h"

#import "FavoritesViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "RegisterViewController.h"
#import "ProjectDetailsViewController.h"

@implementation NavigationManager

+ (void)presentLoggedOutScreenWithSceneDelegate:(SceneDelegate *)sceneDelegate {
    LoginViewController *const loginViewController = [[LoginViewController alloc] init];
    UINavigationController *const loginNavController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [loginNavController setNavigationBarHidden:YES];
    sceneDelegate.window.rootViewController = loginNavController;
    [sceneDelegate.window makeKeyAndVisible];
}

+ (void)presentLoggedInScreenWithSceneDelegate:(SceneDelegate *)sceneDelegate {
    MainTabBarController *const tabBarController = [[MainTabBarController alloc] init];
    sceneDelegate.window.rootViewController = tabBarController;
    [sceneDelegate.window makeKeyAndVisible];
}

+ (void)presentRegistrationScreenWithNavigationController:(UINavigationController *)navController {
    RegisterViewController *const registerViewController = [[RegisterViewController alloc] init];
    [navController pushViewController:registerViewController animated:YES];
    NSLog(@"Reached presentRegistrationScreen in NavManager, navController is? %@", NSStringFromClass([navController class]));
}

+ (void)presentProjectDetailsViewControllerWithNavigationController:(UINavigationController *)navController {
    ProjectDetailsViewController *const projectDetailsViewController = [[ProjectDetailsViewController alloc] init];
    //TODO: pass in a Project object to the new project details view controller
    [navController pushViewController:projectDetailsViewController animated:YES];
}

+ (void)exitTopViewController:(UINavigationController *)navController {
    UIViewController *const poppedVC = [navController popViewControllerAnimated:YES];
    NSString *const vcType = NSStringFromClass([poppedVC class]);
    NSLog(@"Popped a view controller of type %@", vcType);
}

+ (void)exitToRootViewController:(UINavigationController *)navController {
    NSArray<__kindof UIViewController *> *const poppedVCs = [navController popToRootViewControllerAnimated:YES];
    NSLog(@"Popped view controllers of type:");
    for (UIViewController *const vc in poppedVCs) {
        NSLog(@"%@", NSStringFromClass([vc class]));
    }
}

@end
