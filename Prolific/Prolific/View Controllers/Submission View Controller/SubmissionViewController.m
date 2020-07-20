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
    _submitButton.backgroundColor = [UIColor lightGrayColor];
    [_submitButton setTitle:@"Submit a snippet!" forState:normal];
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

- (void)didTapSubmitButton:(id)sender{
    NSLog(@"Tapped submit button");
    [self resignFields];
    
    [self submitSnippet];
    [NavigationManager exitTopViewController:self.navigationController];
}

- (void)onTapBack:(id)sender{
    [self resignFields];
    
    [NavigationManager exitTopViewController:self.navigationController];
}

#pragma mark - Snippet submission

- (void)submitSnippet {
    DAO *const dao = [[DAO alloc] init];
    SnippetBuilder *const snippetBuilder = [[[[SnippetBuilder alloc] init]
                                             withText:_submissionTextView.text]
                                            withAuthor:[FIRAuth auth].currentUser.uid];
    [dao submitSnippetWithBuilder:snippetBuilder forProjectId:_projectId forRoundId:_round.roundId completion:^(Snippet * _Nonnull snippet, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"Snippet submission unsuccessful: %@", error.localizedDescription);
        } else {
            NSLog(@"Snippet submission successful: %@", snippet);
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
