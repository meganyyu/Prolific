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
#import "ProlificErrorLogger.h"
#import "SnippetBuilder.h"
#import "UIColor+ProlificColors.h"

static NSString *const kSubmitIconId = @"submit-icon";

#pragma mark - Interface

@interface ComposeSnippetViewController ()

@property (nonatomic, strong) UIView *composeView;
@property (nonatomic, strong) UITextView *composeTextView;
@property (nonatomic, strong) DAO *dao;

@end

#pragma mark - Implementation

@implementation ComposeSnippetViewController

#pragma mark - Initializer

- (instancetype)initWithRound:(Round *)round
                    projectId:(NSString *)projectId
                 withDelegate:(id<ComposeSnippetViewControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        _round = round;
        _projectId = projectId;
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Compose Snippet";
    [super setupBackButton];
    [self setupSubmitButton];
    
    _composeView = [[UIView alloc] init];
    [self.view addSubview:_composeView];
    
    _composeTextView = [[UITextView alloc] init];
    _composeTextView.backgroundColor = [UIColor ProlificBackgroundGrayColor];
    _composeTextView.textColor = [UIColor blackColor];
    [_composeView addSubview:_composeTextView];
}

- (void)setupSubmitButton {
    UIButton *const submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(0, 0, 40, 40);
    [submitButton setImage:[[UIImage imageNamed:kSubmitIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    [submitButton addTarget:self
                     action:@selector(onTapSubmit:)
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
    
    // submission text view
    CGFloat const textViewX = 0.05 * boundsWidth;
    CGFloat const textViewY = 0.1 * boundsHeight;
    CGFloat const textViewWidth = 0.9 * boundsWidth;
    CGFloat const textViewHeight = boundsHeight;
    _composeTextView.frame = CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_composeTextView endEditing:YES];
}

#pragma mark - User Actions

- (void)onTapBack:(id)sender{
    [NavigationManager exitViewController:self.navigationController];
}

- (void)onTapSubmit:(id)sender{
    [_composeTextView endEditing:YES];
    
    NSString *const cleanedText = [_composeTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![cleanedText isEqualToString:@""]) {
        [self submitSnippetWithCompletion:^(Snippet *snippet, Round *round, NSError *error) {
            if (snippet && round) {
                self.round = round;
                [self.delegate didSubmit:snippet round:round];
                
                __weak typeof(self) weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(self) strongSelf = weakSelf;
                    if (strongSelf) {
                        [NavigationManager exitViewController:self.navigationController];
                    }
                });
            } else {
                [ProlificErrorLogger logErrorWithMessage:[NSString stringWithFormat:@"Failed to submit snippet: %@", error.localizedDescription]
                                        shouldRaiseAlert:YES];
            }
        }];
    }
}

#pragma mark - Snippet submission

- (void)submitSnippetWithCompletion:(void(^)(Snippet *snippet, Round *round, NSError *error))completion {
    SnippetBuilder *const snippetBuilder = [[[SnippetBuilder alloc] init]
                                             withText:_composeTextView.text];
    
    __weak typeof(self) weakSelf = self;
    [_dao submitSnippetWithBuilder:snippetBuilder
                     forProjectId:_projectId
                        forRoundId:_round.roundId
                        completion:^(Snippet *snippet, NSError *error) {
        typeof(self) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (error) {
            completion(nil, nil, error);
        } else {
            RoundBuilder *const roundBuilder = [[RoundBuilder alloc] initWithRound:strongSelf.round];
            Round *const updatedRound = [[roundBuilder addSubmission:snippet]
                                   build];
            completion(snippet, updatedRound, nil);
        }
    }];
}

@end
