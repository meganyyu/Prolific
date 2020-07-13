//
//  ViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Make a test label
    UILabel *const label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    label.text = @"Test Label";

    // Add label to view controller's root view
    [self.view addSubview:label];
}


@end
