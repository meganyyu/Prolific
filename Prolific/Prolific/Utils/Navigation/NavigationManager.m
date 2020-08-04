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
#import "SubmissionsViewController.h"
#import "ProfileViewController.h"
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

+ (void)presentProjectDetailsViewControllerForProject:(Project *)project
                                       forCurrentUser:(User *)currUser
                                 navigationController:(UINavigationController *)navController {
    ProjectDetailsViewController *const projectDetailsViewController = [[ProjectDetailsViewController alloc] initWithProject:project
                                                                                                                 currentUser:currUser];
    
    [navController pushViewController:projectDetailsViewController animated:YES];
}

+ (void)presentProfileViewControllerForUser:(User *)user
                       navigationController:(UINavigationController *)navController {
    ProfileViewController *const profileViewController = [[ProfileViewController alloc] initWithUser:user];
    [navController pushViewController:profileViewController animated:YES];
}

+ (void)presentComposeSnippetViewControllerForRound:(Round *)round
                                          projectId:(NSString *)projectId
                                 fromViewController:(UIViewController<ComposeSnippetViewControllerDelegate> *)fromViewController {
    UINavigationController *const navController = fromViewController.navigationController;
    
    ComposeSnippetViewController *const composeSnippetViewController = [[ComposeSnippetViewController alloc] initWithRound:round
                                                                                                                 projectId:projectId
                                                                                                              withDelegate:fromViewController];
    
    UINavigationController *const newNavController = [[UINavigationController alloc] initWithRootViewController:composeSnippetViewController];
    newNavController.modalPresentationStyle = UIModalPresentationFullScreen;
    [navController presentViewController:newNavController animated:YES completion:nil];
}

+ (void)presentSubmissionsViewControllerForRound:(Round *)round
                                         project:(Project *)project
                                         forUser:(User *)user
                            navigationController:(UINavigationController *)navController {
    SubmissionsViewController *const submissionsViewController = [[SubmissionsViewController alloc] initWithRound:round
                                                                                                          project:project
                                                                                                      currentUser:user];
    [navController pushViewController:submissionsViewController animated:YES];
}

+ (void)exitTopViewController:(UINavigationController *)navController {
    [navController popViewControllerAnimated:YES];
}

+ (void)exitTopViewControllerWithUpdatedProject:(Project *)project
                           navigationController:(UINavigationController *)navController {
    if ([navController.topViewController isKindOfClass:[SubmissionsViewController class]]) {
        ((ProjectDetailsViewController *) navController.presentingViewController).project = project;
    }
    [navController popViewControllerAnimated:YES];
}

+ (void)exitToRootViewController:(UINavigationController *)navController {
    [navController popToRootViewControllerAnimated:YES];
}

+ (void)exitViewController:(UINavigationController *)navController {
    [navController dismissViewControllerAnimated:YES completion:nil];
}

@end
