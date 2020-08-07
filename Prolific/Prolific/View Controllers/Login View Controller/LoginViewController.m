//
//  LoginViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "LoginViewController.h"

@import FirebaseAuth;
@import FirebaseFirestore;
#import "NavigationManager.h"
#import "SceneDelegate.h"
#import "UIColor+ProlificColors.h"

static NSString *const kEmailKey = @"email";
static NSString *const kPasswordKey = @"password";

#pragma mark - Interface

@interface LoginViewController ()

@property (nonatomic, strong) UIView *loginContentView;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *goToRegisterButton;
@property (nonatomic, strong) UILabel *errorLabel;

@end

#pragma mark - Implementation

@implementation LoginViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginContentView = [[UIView alloc] init];
    _loginContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loginContentView];
    
    _emailField = [[UITextField alloc] init];
    _emailField.backgroundColor = [UIColor whiteColor];
    _emailField.placeholder = @"Email";
    _emailField.borderStyle = UITextBorderStyleRoundedRect;
    _emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_loginContentView addSubview:_emailField];
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.placeholder = @"Password";
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordField.secureTextEntry = YES;
    [_loginContentView addSubview:_passwordField];
    
    _loginButton = [[UIButton alloc] init];
    _loginButton.backgroundColor = [UIColor ProlificPrimaryBlueColor];
    [_loginButton setTitle:@"Login" forState:normal];
    _loginButton.tintColor = [UIColor whiteColor];
    _loginButton.layer.cornerRadius = 5;
    _loginButton.clipsToBounds = YES;
    [_loginContentView addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(didTapLoginButton:)
           forControlEvents:UIControlEventTouchUpInside];
    
    _goToRegisterButton = [[UIButton alloc] init];
    _goToRegisterButton.backgroundColor = [UIColor lightGrayColor];
    [_goToRegisterButton setTitle:@"Don't have an account?" forState:normal];
    _goToRegisterButton.titleLabel.textColor = [UIColor ProlificPrimaryBlueColor];
    _goToRegisterButton.tintColor = [UIColor whiteColor];
    _goToRegisterButton.layer.cornerRadius = 5;
    _goToRegisterButton.clipsToBounds = YES;
    [_loginContentView addSubview:_goToRegisterButton];
    [_goToRegisterButton addTarget:self action:@selector(didTapGoToRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _errorLabel = [[UILabel alloc] init];
    _errorLabel.textColor = [UIColor ProlificRedColor];
    _errorLabel.numberOfLines = 0;
    [_loginContentView addSubview:_errorLabel];
}

- (void)viewDidLayoutSubviews { //FIXME: should I be setting frames or bounds?
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGPoint const center = self.view.center;
    
    // login content view
    CGFloat const viewWidth = boundsWidth;
    CGFloat const viewHeight = boundsHeight * 0.5;
    CGFloat const viewX = center.x - viewWidth / 2;
    CGFloat const viewY = center.y - viewHeight / 2;
    _loginContentView.frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);

    // email field
    CGFloat const fieldWidth = viewWidth * 0.75;
    CGFloat const fieldHeight = (viewHeight * 0.75) / 5.0;
    CGFloat const emailFieldX = _loginContentView.center.x - fieldWidth / 2;
    CGFloat const emailFieldY = 0;
    _emailField.frame = CGRectMake(emailFieldX, emailFieldY, fieldWidth, fieldHeight);
    
    // password field
    CGFloat const passwordFieldX = emailFieldX;
    CGFloat const passwordFieldY = emailFieldY + fieldHeight;
    _passwordField.frame = CGRectMake(passwordFieldX, passwordFieldY, fieldWidth, fieldHeight);
    
    // error label
    CGFloat const errorLabelX = emailFieldX;
    CGFloat const errorLabelY = viewHeight - fieldHeight;
    _errorLabel.alpha = 0;
    _errorLabel.frame = CGRectMake(errorLabelX, errorLabelY, fieldWidth, fieldHeight);
    
    // register button
    CGFloat const registerButtonX = emailFieldX;
    CGFloat const registerButtonY = errorLabelY - fieldHeight - 10;
    _goToRegisterButton.frame = CGRectMake(registerButtonX, registerButtonY, fieldWidth, fieldHeight);
    
    // login button
    CGFloat const loginButtonX = emailFieldX;
    CGFloat const loginButtonY = registerButtonY - fieldHeight - 10;
    _loginButton.frame = CGRectMake(loginButtonX, loginButtonY, fieldWidth, fieldHeight);
}

#pragma mark - User Actions

- (void)didTapLoginButton:(id)sender{
    [self resignFields];
    
    [self loginUserWithEmail:_emailField.text password:_passwordField.text];
}

- (void)didTapGoToRegisterButton:(id)sender{
    [self resignFields];
    
    [NavigationManager presentRegistrationScreenWithNavigationController:self.navigationController];
}

#pragma mark - Existing user authentication

- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password {
    NSString *const fieldEntryError = [self validateFields];
    
    if (fieldEntryError) {
        [self showError:fieldEntryError];
    } else {
        [self hideError];
        
        NSDictionary *const cleanedFields = [self getCleanedFields];
        
        [[FIRAuth auth] signInWithEmail:cleanedFields[kEmailKey]
                               password:cleanedFields[kPasswordKey]
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
            if (!error) {
                [self hideError];
                
                [self authenticatedTransition];
            } else {
                [self showError:error.localizedDescription];
            }
        }];
    }
}

#pragma mark - Helper functions

- (void)showError:(NSString *)message {
    _errorLabel.text = message;
    _errorLabel.alpha = 1;
}

- (void)hideError {
    _errorLabel.alpha = 0;
}

- (void)resignFields {
    if (_emailField.isFirstResponder || _passwordField.isFirstResponder) {
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
    }
}

/** Returns a dictionary of the cleaned data fields. */
- (NSDictionary *)getCleanedFields {
    NSString *const cleanedEmail = [_emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *const cleanedPassword = [_passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            cleanedEmail, kEmailKey,
            cleanedPassword, kPasswordKey, nil];
}

/** Check the fields and validate that the data is correct. If everything is correct, method returns nil. Otherwise, returns error message as a string. */
- (NSString *)validateFields {
    NSDictionary *cleanedFields = [self getCleanedFields];

    // check that all fields are filled in
    if ([cleanedFields[kEmailKey] isEqualToString:@""] ||
        [cleanedFields[kPasswordKey] isEqualToString:@""]) {
        return @"Please fill in all fields";
    }
    
    return nil;
}

#pragma mark - Navigation

- (void)authenticatedTransition {
    SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [NavigationManager presentLoggedInScreenWithSceneDelegate:sceneDelegate];
}

@end
