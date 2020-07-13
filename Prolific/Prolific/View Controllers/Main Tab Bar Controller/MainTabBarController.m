//
//  MainTabBarController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "MainTabBarController.h"

#import "HomeViewController.h"
#import "FavoritesViewController.h"

#pragma mark - Interface

@interface MainTabBarController ()

@end

#pragma mark - Implementation

@implementation MainTabBarController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];

    HomeViewController *const homeViewController = [[HomeViewController alloc] init];
    FavoritesViewController *const favoritesViewController = [[FavoritesViewController alloc] init];
    self.viewControllers = @[homeViewController, favoritesViewController];
    
    UITabBar *const tabBar = (UITabBar *)self.tabBar;
    UITabBarItem *const homeTabItem = [tabBar.items objectAtIndex:0];
    homeTabItem.title = @"Home";
    UITabBarItem *const favoritesTabItem = [tabBar.items objectAtIndex:1];
    favoritesTabItem.title = @"Favorites";
    
    NSLog(@"Reached end of MainTabBarController viewDidLoad");
}
@end
