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
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface NavigationManager : NSObject

/** Presents screen for logging in after user logs out. */
+ (void)presentLoggedOutScreenWithSceneDelegate:(SceneDelegate *)sceneDelegate;

/** Presents main screen after user logs in with tab bar controller set up. */
+ (void)presentLoggedInScreenWithSceneDelegate:(SceneDelegate *)sceneDelegate;

/** Presents Registration screen. */
+ (void)presentRegistrationScreenWithNavigationController:(UINavigationController *)navController;

/** Presents ProjectDetailsViewController and passes in necessary view controller properties. */
+ (void)presentProjectDetailsViewControllerForProject:(Project *)project
                                       forCurrentUser:(User *)currUser
                                 navigationController:(UINavigationController *)navController;

/** Presents ProfileViewController and passes in necessary view controller properties. */
+ (void)presentProfileViewControllerForUser:(User *)user
                       navigationController:(UINavigationController *)navController;

/** Presents ComposeSnippetViewController and passes in necessary view controller properties. */
+ (void)presentComposeSnippetViewControllerForRound:(Round *)round
                                          projectId:(NSString *)projectId
                               navigationController:(UINavigationController *)navController;

/** Presents SubmissionsViewController and passes in necessary view controller properties. */
+ (void)presentSubmissionsViewControllerForRound:(Round *)round
                                         project:(Project *)project
                                         forUser:(User *)user
                            navigationController:(UINavigationController *)navController;

/** Exits topmost view controller in the navigation controller stack. */
+ (void)exitTopViewController:(UINavigationController *)navController;

/** Exits topmost view controller in the navigation controller stack, and passes back updated project. */
+ (void)exitTopViewControllerWithUpdatedProject:(Project *)project
                           navigationController:(UINavigationController *)navController;

/** Exits to the root view controller of the navigation controller stack. */
+ (void)exitToRootViewController:(UINavigationController *)navController;

/** Exits current view controller. If it's the root view controller, it also exits the navigation controller. */
+ (void)exitViewController:(UINavigationController *)navController;

@end

NS_ASSUME_NONNULL_END
