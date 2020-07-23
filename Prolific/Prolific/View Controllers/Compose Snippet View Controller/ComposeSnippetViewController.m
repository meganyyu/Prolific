//
//  ComposeSnippetViewController.m
//  Prolific
//
//  Created by meganyu on 7/17/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ComposeSnippetViewController.h"

@import FirebaseAuth;
#import "DAO.h"
#import "NavigationManager.h"
#import "SnippetBuilder.h"
#import "UIColor+ProlificColors.h"

@interface ComposeSnippetViewController ()

@property (nonatomic, strong) UIView *composeView;
@property (nonatomic, strong) UITextView *composeTextView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) DAO *dao;

@end

@implementation ComposeSnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Project Details";
    UIButton *const backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back-arrow-icon"]
                forState:UIControlStateNormal];
    [backButton addTarget:self
                 action:@selector(onTapBack:)
       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    _composeView = [[UIView alloc] init];
    [self.view addSubview:_composeView];
    
    _composeTextView = [[UITextView alloc] init];
    _composeTextView.backgroundColor = [UIColor whiteColor];
    _composeTextView.textColor = [UIColor blackColor];
    [_composeView addSubview:_composeTextView];
    
    _submitButton = [[UIButton alloc] init];
    _submitButton.backgroundColor = [UIColor ProlificPrimaryBlueColor];
    _submitButton.titleLabel.textColor = [UIColor whiteColor];
    [_submitButton setTitle:@"Submit!" forState:normal];
    [_submitButton addTarget:self action:@selector(onTapSubmit:)
            forControlEvents:UIControlEventTouchUpInside];
    [_composeView addSubview:_submitButton];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // submission view
    _composeView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // submission text view
    CGFloat const textViewX = 0.1 * boundsWidth;
    CGFloat const textViewY = 0.1 * boundsHeight;
    CGFloat const textViewWidth = 0.8 * boundsWidth;
    CGFloat const textViewHeight = 0.6 * boundsHeight;
    _composeTextView.frame = CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight);
    
    // submission button
    CGFloat const submitButtonX = _composeView.center.x - 75;
    CGFloat const submitButtonY = boundsHeight - 300;
    _submitButton.frame = CGRectMake(submitButtonX, submitButtonY, 150, 30);
}

#pragma mark - User Actions

- (void)onTapSubmit:(id)sender{
    [self resignFields];
    
    [self submitSnippetWithCompletion:^(Snippet *snippet, Round *round, NSError *error) {
        if (snippet) {
            [self.delegate didSubmit:snippet round:round];
            
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [NavigationManager exitTopViewController:strongSelf.navigationController];
                }
            });
        } else {
            NSLog(@"Failed to submit snippet, try again.");
        }
    }];
}

- (void)onTapBack:(id)sender{
    [self resignFields];
    
    [NavigationManager exitTopViewController:self.navigationController];
}

#pragma mark - Snippet submission

- (void)submitSnippetWithCompletion:(void(^)(Snippet *snippet, Round *round, NSError *error))completion {
    SnippetBuilder *const snippetBuilder = [[[SnippetBuilder alloc] init]
                                             withText:_composeTextView.text];
    [_dao submitSnippetWithBuilder:snippetBuilder
                     forProjectId:_projectId
                        forRoundId:_round.roundId
                        completion:^(Snippet *snippet, NSError *error) {
        if (error) {
            completion(nil, nil, error);
        } else {
            [self.round.submissions addObject:snippet];
            completion(snippet, self.round, nil);
        }
    }];
}

#pragma mark - Helper functions

- (void)resignFields {
    if (_composeTextView.isFirstResponder) {
        [_composeTextView resignFirstResponder];
    }
}

@end
