//
//  ProlificBaseViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

@interface ProlificBaseViewController ()

@end

@implementation ProlificBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    //[appearance configureWithOpaqueBackground];
    [appearance setBackgroundColor:[UIColor whiteColor]];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightTextColor]}];
    
    self.navigationItem.standardAppearance = appearance;
    self.navigationItem.scrollEdgeAppearance = appearance;
    self.navigationItem.compactAppearance = appearance;
}

@end
