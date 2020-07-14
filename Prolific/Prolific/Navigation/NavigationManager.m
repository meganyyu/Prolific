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
#import "ThreadDetailsViewController.h"

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

+ (void)presentThreadDetailsViewControllerWithNavigationController:(UINavigationController *)navController {
    ThreadDetailsViewController *const threadDetailsViewController = [[ThreadDetailsViewController alloc] init];
    //TODO: pass in a Thread object to the new thread details view controller
    [navController pushViewController:threadDetailsViewController animated:YES];
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
