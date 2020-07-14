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

@property (nonatomic, strong) UINavigationController *homeNavigationController;
@property (nonatomic, strong) UINavigationController *favoritesNavigationController;

@end

#pragma mark - Implementation

@implementation MainTabBarController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViewControllers];
    
    UITabBar *const tabBar = (UITabBar *)self.tabBar;
    
    UITabBarItem *const homeTabItem = [tabBar.items objectAtIndex:0];
    homeTabItem.title = @"Home";
    UITabBarItem *const favoritesTabItem = [tabBar.items objectAtIndex:1];
    favoritesTabItem.title = @"Favorites";
    
    UITabBarAppearance *const tabBarAppearance = [[UITabBarAppearance alloc] init];
    [tabBarAppearance setBackgroundColor:[UIColor whiteColor]];
    [self setTabBarItemColors:tabBarAppearance.stackedLayoutAppearance];
    tabBar.standardAppearance = tabBarAppearance;
    
    NSLog(@"Reached end of MainTabBarController viewDidLoad");
}

- (void)setupViewControllers {
    HomeViewController *const homeViewController = [[HomeViewController alloc] init];
    _homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    FavoritesViewController *const favoritesViewController = [[FavoritesViewController alloc] init];
    _favoritesNavigationController = [[UINavigationController alloc] initWithRootViewController:favoritesViewController];
    
    self.viewControllers = @[_homeNavigationController, _favoritesNavigationController];
}

- (void)setTabBarItemColors:(UITabBarItemAppearance *)itemAppearance {
    itemAppearance.normal.iconColor = [UIColor lightGrayColor];
    [itemAppearance.normal setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    itemAppearance.selected.iconColor = [UIColor greenColor];
    [itemAppearance.selected setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
}

@end
