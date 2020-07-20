//
//  SubmissionViewController.m
//  Prolific
//
//  Created by meganyu on 7/17/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SubmissionViewController.h"

@import FirebaseAuth;
#import "DAO.h"
#import "NavigationManager.h"
#import "SnippetBuilder.h"

@interface SubmissionViewController ()

@property (nonatomic, strong) UIView *submissionView;
@property (nonatomic, strong) UITextView *submissionTextView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation SubmissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.title = @"Project Details";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onTapBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    _submissionView = [[UIView alloc] init];
    _submissionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_submissionView];
    
    _submissionTextView = [[UITextView alloc] init];
    _submissionTextView.backgroundColor = [UIColor whiteColor];
    _submissionTextView.textColor = [UIColor blackColor];
    [_submissionView addSubview:_submissionTextView];
    
    _submitButton = [[UIButton alloc] init];
    _submitButton.backgroundColor = [UIColor blueColor];
    [_submitButton setTitle:@"Submit!" forState:normal];
    [_submitButton addTarget:self action:@selector(onTapSubmit:) forControlEvents:UIControlEventTouchUpInside];
    _submitButton.tintColor = [UIColor whiteColor];
    [_submissionView addSubview:_submitButton];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // submission view
    _submissionView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // submission text view
    CGFloat const textViewX = 0.1 * boundsWidth;
    CGFloat const textViewY = 0.1 * boundsHeight;
    CGFloat const textViewWidth = 0.8 * boundsWidth;
    CGFloat const textViewHeight = 0.6 * boundsHeight;
    _submissionTextView.frame = CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight);
    
    // submission button
    CGFloat const submitButtonX = _submissionView.center.x - 75;
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
    DAO *const dao = [[DAO alloc] init];
    SnippetBuilder *const snippetBuilder = [[[SnippetBuilder alloc] init]
                                             withText:_submissionTextView.text];
    [dao submitSnippetWithBuilder:snippetBuilder
                     forProjectId:_projectId
                         forRound: _round
                       completion:^(Snippet *snippet, Round *round, NSError *error) {
        if (error) {
            completion(nil, nil, error);
        } else {
            completion(snippet, round, nil);
        }
    }];
}

#pragma mark - Helper functions

- (void)resignFields {
    if (_submissionTextView.isFirstResponder) {
        [_submissionTextView resignFirstResponder];
    }
}

@end
