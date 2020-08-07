//
//  CreateProjectViewController.m
//  Prolific
//
//  Created by meganyu on 8/7/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "CreateProjectViewController.h"

@import FirebaseAuth;
#import "DAO.h"
#import "NavigationManager.h"
#import "ProlificErrorLogger.h"
#import "ProjectBuilder.h"
#import "UIColor+ProlificColors.h"

static NSString *const kSubmitIconId = @"submit-icon";

#pragma mark - Interface

@interface CreateProjectViewController ()

@property (nonatomic, strong) DAO *dao;

@end

#pragma mark - Implementation

@implementation CreateProjectViewController

#pragma mark - Initializer

- (instancetype)initWithDelegate:(id<CreateProjectViewControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        _dao = [[DAO alloc] init];
    }
    return self;
}

@end
