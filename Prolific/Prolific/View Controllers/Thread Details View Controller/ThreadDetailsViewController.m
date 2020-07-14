//
//  ThreadDetailsViewController.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ThreadDetailsViewController.h"

#import "NavigationManager.h"

#pragma mark - Interface

@interface ThreadDetailsViewController ()

@end

#pragma mark - Implementation

@implementation ThreadDetailsViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Test label
    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 30)];
    label.text = @"Test Label for Thread Details View Controller";

    [self.view addSubview:label];
    
    self.navigationItem.title = @"Thread Details";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onTapBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

#pragma mark - User actions

- (void)onTapBack:(id)sender {
    [NavigationManager exitTopViewController:self.navigationController];
}

@end
