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
    
    // Test label
    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 30)];
    label.text = @"Test Label for Favorites View Controller";

    [self.view addSubview:label];
}

@end
