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
    _titleTextField.textAlignment = NSTextAlignmentCenter;
    _titleTextField.placeholder = @"Untitled";
    _titleTextField.font = [UIFont systemFontOfSize:24];
    [_composeView addSubview:_titleTextField];
    
    _seedTextView = [[UITextView alloc] init];
    _seedTextView.backgroundColor = [UIColor ProlificBackgroundGrayColor];
    _seedTextView.textColor = [UIColor blackColor];
    _seedTextView.font = [UIFont systemFontOfSize:18];
    _seedTextView.text = @"What happens first?";
    [_composeView addSubview:_seedTextView];
    [_seedTextView becomeFirstResponder];
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // submission view
    _composeView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // title text field
    CGFloat const titleFieldX = 0.05 * boundsWidth;
    CGFloat const titleFieldY = self.navigationController.navigationBar.frame.size.height + 0.1 * boundsHeight;
    CGFloat const titleFieldWidth = 0.9 * boundsWidth;
    CGFloat const titleFieldHeight = 0.05 * boundsHeight;
    _titleTextField.frame = CGRectMake(titleFieldX, titleFieldY, titleFieldWidth, titleFieldHeight);
    
    // title text field's bottom border
    CALayer *const border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor ProlificGray2Color].CGColor;
    border.frame = CGRectMake(0, _titleTextField.frame.size.height - borderWidth, _titleTextField.frame.size.width, _titleTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [_titleTextField.layer addSublayer:border];
    _titleTextField.layer.masksToBounds = YES;
    
    // submission text view
    CGFloat const textViewX = titleFieldX;
    CGFloat const textViewY = titleFieldY + titleFieldHeight + textViewX;
    CGFloat const textViewWidth = titleFieldWidth;
    CGFloat const textViewHeight = boundsHeight - textViewY;
    _seedTextView.frame = CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight);
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
