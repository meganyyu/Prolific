//
//  ViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "HomeViewController.h"

#pragma mark - Interface

@interface HomeViewController ()

@end

#pragma mark - Implementation

@implementation HomeViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // Make a test label
    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 300, 30)];
    label.text = @"Test Label for Home View Controller";

    // Add label to view controller's root view
    [self.view addSubview:label];
}

@end
