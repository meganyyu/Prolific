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
#import "UnderlinedTextField.h"

static NSString *const kEmailKey = @"email";
static NSString *const kPasswordKey = @"password";
static NSString *const kMainLogoIconId = @"main-logo-primary";

#pragma mark - Interface

@interface LoginViewController ()

@property (nonatomic, strong) UnderlinedTextField *emailField;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIView *loginContentView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *logoIconView;
@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UIButton *goToRegisterButton;
@property (nonatomic, strong) UnderlinedTextField *passwordField;

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
    
    _logoIconView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:kMainLogoIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_loginContentView addSubview:_logoIconView];
    
    _welcomeLabel = [[UILabel alloc] init];
    _welcomeLabel.text = @"Welcome";
    _welcomeLabel.textAlignment = NSTextAlignmentCenter;
    _welcomeLabel.textColor = [UIColor ProlificPrimaryBlueColor];
    _welcomeLabel.font = [UIFont systemFontOfSize:48 weight:UIFontWeightBold];
    [_loginContentView addSubview:_welcomeLabel];
    
    _emailField = [[UnderlinedTextField alloc] init];
    _emailField.placeholder = @"Email";
    [_loginContentView addSubview:_emailField];
    
    _passwordField = [[UnderlinedTextField alloc] init];
    _passwordField.placeholder = @"Password";
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
    _errorLabel.textAlignment = NSTextAlignmentCenter;
    _errorLabel.numberOfLines = 0;
    [_loginContentView addSubview:_errorLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGPoint const center = self.view.center;
    
    // login content view
    _loginContentView.frame = self.view.frame;

    // logo icon
    CGFloat const logoWidth = 110;
    CGFloat const logoHeight = 110;
    CGFloat const logoX = center.x - logoWidth / 2;
    CGFloat const logoY = 0.2 * boundsHeight;
    _logoIconView.frame = CGRectMake(logoX, logoY, logoWidth, logoHeight);

    
    CGFloat const fieldWidth = boundsWidth * 0.75;
    CGFloat const fieldHeight = 70;
    CGFloat const fieldX = center.x - fieldWidth / 2;
    
    // welcome label
    CGFloat const welcomeLabelY = logoY + logoHeight;
    _welcomeLabel.frame = CGRectMake(fieldX, welcomeLabelY, fieldWidth, fieldHeight);
    
    // email field
    CGFloat const emailFieldY = welcomeLabelY + fieldHeight + 20;
    _emailField.frame = CGRectMake(fieldX, emailFieldY, fieldWidth, fieldHeight);
    
    // password field
    CGFloat const passwordFieldY = emailFieldY + fieldHeight + 5;
    _passwordField.frame = CGRectMake(fieldX, passwordFieldY, fieldWidth, fieldHeight);
    
    // error label
    CGFloat const errorLabelY = 0.85 * boundsHeight;
    _errorLabel.alpha = 0;
    _errorLabel.frame = CGRectMake(fieldX, errorLabelY, fieldWidth, fieldHeight);
    
    // register button
    CGFloat const registerButtonY = errorLabelY - fieldHeight - 10;
    _goToRegisterButton.frame = CGRectMake(fieldX, registerButtonY, fieldWidth, fieldHeight);
    
    // login button
    CGFloat const loginButtonY = registerButtonY - fieldHeight - 10;
    _loginButton.frame = CGRectMake(fieldX, loginButtonY, fieldWidth, fieldHeight);
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
