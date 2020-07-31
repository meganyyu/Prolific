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
#import "UIColor+ProlificColors.h"

static NSString *const kUntappedExploreIcon = @"untapped-explore-icon";
static NSString *const kTappedExploreIcon = @"tapped-explore-icon";
static NSString *const kUntappedFavoritesIcon = @"untapped-vote-icon";
static NSString *const kTappedFavoritesIcon = @"finished-vote-icon";

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
    [homeTabItem setImage:[[UIImage imageNamed:kUntappedExploreIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homeTabItem setSelectedImage:[[UIImage imageNamed:kTappedExploreIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarItem *const favoritesTabItem = [tabBar.items objectAtIndex:1];
    [favoritesTabItem setImage:[[UIImage imageNamed:kUntappedFavoritesIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [favoritesTabItem setSelectedImage:[[UIImage imageNamed:kTappedFavoritesIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarAppearance *const tabBarAppearance = [[UITabBarAppearance alloc] init];
    [tabBarAppearance setBackgroundColor:[UIColor whiteColor]];
    [self setTabBarItemColors:tabBarAppearance.stackedLayoutAppearance];
    tabBar.standardAppearance = tabBarAppearance;
}

- (void)setupViewControllers {
    HomeViewController *const homeViewController = [[HomeViewController alloc] init];
    _homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    FavoritesViewController *const favoritesViewController = [[FavoritesViewController alloc] init];
    _favoritesNavigationController = [[UINavigationController alloc] initWithRootViewController:favoritesViewController];
    
    self.viewControllers = @[_homeNavigationController, _favoritesNavigationController];
}

- (void)setTabBarItemColors:(UITabBarItemAppearance *)itemAppearance {
    itemAppearance.normal.iconColor = [UIColor ProlificGray1Color];
    [itemAppearance.normal setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ProlificGray1Color]}];
    
    itemAppearance.selected.iconColor = [UIColor ProlificPrimaryBlueColor];
    [itemAppearance.selected setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ProlificPrimaryBlueColor]}];
}

@end
