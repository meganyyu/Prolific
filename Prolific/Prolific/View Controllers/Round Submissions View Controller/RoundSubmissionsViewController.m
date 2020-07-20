//
//  RoundSubmissionsViewController.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundSubmissionsViewController.h"

@import FirebaseAuth;
#import "DAO.h"
#import "NavigationManager.h"

@interface RoundSubmissionsViewController ()

@property (nonatomic, strong) UIView *submissionView;

@property (nonatomic, strong) DAO *dao;

@end

@implementation RoundSubmissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.title = @"Round Submissions";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onTapBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    _submissionView = [[UIView alloc] init];
    _submissionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_submissionView];
    
    [self refreshData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // submission view
    _submissionView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
}

#pragma mark - Load submissions

- (void)refreshData {
    [_dao getAllSubmissionsforRoundId:_round.roundId projectId:_projectId completion:^(NSMutableArray * _Nonnull submissions, NSError * _Nonnull error) {
        if (submissions) {
            for (Snippet *snippet in submissions) {
                NSLog(@"Snippet text: %@", snippet.text);
            }
        }
    }];
}

#pragma mark - User Actions

- (void)onTapBack:(id)sender{
    [NavigationManager exitTopViewController:self.navigationController];
}

@end
