//
//  ProlificBaseViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "NavigationManager.h"
#import "UIColor+ProlificColors.h"

static NSString *const kBackArrowIconId = @"back-arrow-icon";

@interface ProlificBaseViewController ()

@end

@implementation ProlificBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ProlificBackgroundGrayColor];
    
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    //[appearance configureWithOpaqueBackground];
    [appearance setBackgroundColor:[UIColor whiteColor]];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ProlificPrimaryBlueColor]}];
    
    self.navigationItem.standardAppearance = appearance;
    self.navigationItem.scrollEdgeAppearance = appearance;
    self.navigationItem.compactAppearance = appearance;
}

- (void)setupBackButton {
    UIButton *const backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[[UIImage imageNamed:kBackArrowIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    [backButton addTarget:self
                 action:@selector(onTapBack:)
       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

#pragma mark - User Actions

- (void)onTapBack:(id)sender{
    [NavigationManager exitTopViewController:self.navigationController];
}

@end
