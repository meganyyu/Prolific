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
#import "SubmissionViewController.h"
#import "RoundSubmissionsViewController.h"
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
}

+ (void)presentProjectDetailsViewControllerForProject:(Project *)project navigationController:(UINavigationController *)navController {
    ProjectDetailsViewController *const projectDetailsViewController = [[ProjectDetailsViewController alloc] init];
    projectDetailsViewController.project = project;
    [navController pushViewController:projectDetailsViewController animated:YES];
}

+ (void)presentSubmissionViewControllerForRound:(Round *)round projectId:(NSString *)projectId navigationController:(UINavigationController *)navController {
    SubmissionViewController *const submissionViewController = [[SubmissionViewController alloc] init];
    submissionViewController.round = round;
    submissionViewController.projectId = projectId;
    [navController pushViewController:submissionViewController animated:YES];
}

+ (void)presentRoundSubmissionsViewControllerForRound:(Round *)round projectId:(NSString *)projectId navigationController:(UINavigationController *)navController {
    RoundSubmissionsViewController *const roundSubmissionsViewController = [[RoundSubmissionsViewController alloc] init];
    roundSubmissionsViewController.round = round;
    roundSubmissionsViewController.projectId = projectId;
    [navController pushViewController:roundSubmissionsViewController animated:YES];
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
