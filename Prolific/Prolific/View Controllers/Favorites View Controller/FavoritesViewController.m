//
//  FavoritesViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FavoritesViewController.h"

#pragma mark - Interface

@interface FavoritesViewController ()

@end

#pragma mark - Implementation

@implementation FavoritesViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    // Make a test label
    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 300, 30)];
    label.text = @"Test Label for Favorites View Controller";

    // Add label to view controller's root view
    [self.view addSubview:label];
}

@end
