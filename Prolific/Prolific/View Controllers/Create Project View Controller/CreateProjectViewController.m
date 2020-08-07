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

@property (nonatomic, strong) UIView *composeView;
@property (nonatomic, strong) UITextView *seedTextView;
@property (nonatomic, strong) UITextField *titleTextField;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Create Project";
    [super setupBackButton];
    [self setupSubmitButton];
    
    _composeView = [[UIView alloc] init];
    [self.view addSubview:_composeView];
    
    _titleTextField = [[UITextField alloc] init];
    [_composeView addSubview:_titleTextField];
    [_titleTextField becomeFirstResponder];
    
    _seedTextView = [[UITextView alloc] init];
    _seedTextView.backgroundColor = [UIColor ProlificBackgroundGrayColor];
    _seedTextView.textColor = [UIColor blackColor];
    [_composeView addSubview:_seedTextView];
}

- (void)setupSubmitButton {
    UIButton *const submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(0, 0, 40, 40);
    [submitButton setImage:[[UIImage imageNamed:kSubmitIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    [submitButton addTarget:self
                     action:@selector(onTapCreate:)
           forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_titleTextField endEditing:YES];
    [_seedTextView endEditing:YES];
}

#pragma mark - User Actions

- (void)onTapBack:(id)sender{
    [NavigationManager exitViewController:self.navigationController];
}

- (void)onTapCreate:(id)sender{
    
}

@end
