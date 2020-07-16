//
//  ProjectDetailsViewController.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectDetailsViewController.h"

#import "NavigationManager.h"

#pragma mark - Interface

@interface ProjectDetailsViewController ()

@property (nonatomic, strong) UIView *projectView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;

@end

#pragma mark - Implementation

@implementation ProjectDetailsViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Project Details";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onTapBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    _projectView = [[UIView alloc] init];
    _projectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_projectView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.numberOfLines = 0;
    [_projectView addSubview:_nameLabel];
    
    _seedContentLabel = [[UILabel alloc] init];
    _seedContentLabel.textColor = [UIColor blackColor];
    _seedContentLabel.numberOfLines = 0;
    [_projectView addSubview:_seedContentLabel];
    
    [self refreshData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // cell view
    _projectView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // project name label
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    CGFloat const nameLabelHeight = 0.2 * boundsHeight;
    CGFloat const nameLabelY = 0.05 * boundsHeight;
    NSLog(@"labelWidth: %f, nameLabelHeight: %f, labelX: %f, nameLabelY: %f", labelWidth, nameLabelHeight, labelX, nameLabelY);
    _nameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    
    // seed content label
    CGFloat const seedContentLabelHeight = 0.6 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    NSLog(@"labelWidth: %f, seedContentLabelHeight: %f, labelX: %f, seedContentLabelY: %f", labelWidth, seedContentLabelHeight, labelX, seedContentLabelY);
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
}

- (void)refreshData {
    _nameLabel.text = _project.name;
    _seedContentLabel.text = _project.seed;
}

#pragma mark - User actions

- (void)onTapBack:(id)sender {
    [NavigationManager exitTopViewController:self.navigationController];
}

@end
