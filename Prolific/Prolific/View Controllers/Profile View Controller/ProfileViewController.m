//
//  ProfileViewController.m
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProfileViewController.h"

#import "DAO.h"
#import "UIColor+ProlificColors.h"

@interface ProfileViewController ()

@property (nonatomic, strong) DAO *dao;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Profile";
    [super setupBackButton];
}

@end
