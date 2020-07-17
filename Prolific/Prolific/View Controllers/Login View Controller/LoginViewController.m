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

#pragma mark - Interface

@interface LoginViewController ()

@property (nonatomic, strong) UIView *loginContentView;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *goToRegisterButton;

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
    [_loginContentView addSubview:_passwordField];
    
    _loginButton = [[UIButton alloc] init];
    _loginButton.backgroundColor = [UIColor blueColor];
    [_loginButton setTitle:@"Login" forState:normal];
    _loginButton.tintColor = [UIColor whiteColor];
    _loginButton.layer.cornerRadius = 5;
    _loginButton.clipsToBounds = YES;
    [_loginContentView addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(didTapLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _goToRegisterButton = [[UIButton alloc] init];
    _goToRegisterButton.backgroundColor = [UIColor lightGrayColor];
    [_goToRegisterButton setTitle:@"Don't have an account?" forState:normal];
    _goToRegisterButton.tintColor = [UIColor whiteColor];
    _goToRegisterButton.layer.cornerRadius = 5;
    _goToRegisterButton.clipsToBounds = YES;
    [_loginContentView addSubview:_goToRegisterButton];
    [_goToRegisterButton addTarget:self action:@selector(didTapGoToRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews { //FIXME: should I be setting frames or bounds?
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGPoint const center = self.view.center;
    NSLog(@"frameWidth: %f, frameHeight: %f, centerX: %f, centerY: %f", boundsWidth, boundsHeight, center.x, center.y);
    
    // login content view
    CGFloat const viewWidth = boundsWidth;
    CGFloat const viewHeight = boundsHeight * 0.4;
    CGFloat const viewX = center.x - viewWidth / 2;
    CGFloat const viewY = center.y - viewHeight / 2;
    NSLog(@"viewWidth: %f, viewHeight: %f, viewX: %f, viewY: %f", viewWidth, viewHeight, viewX, viewY);
    _loginContentView.frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);

    // email field
    CGFloat const fieldWidth = viewWidth * 0.75;
    CGFloat const fieldHeight = (viewHeight * 0.75) / 4;
    CGFloat const emailFieldX = _loginContentView.center.x - fieldWidth / 2;
    CGFloat const emailFieldY = 0;
    NSLog(@"fieldWidth: %f, fieldHeight: %f, emailFieldX: %f, emailFieldY: %f", fieldWidth, fieldHeight, emailFieldX, emailFieldY);
    _emailField.frame = CGRectMake(emailFieldX, emailFieldY, fieldWidth, fieldHeight);
    
    // password field
    CGFloat const passwordFieldX = emailFieldX;
    CGFloat const passwordFieldY = emailFieldY + fieldHeight;
    NSLog(@"passwordFieldX: %f, passwordFieldY: %f", passwordFieldX, passwordFieldY);
    _passwordField.frame = CGRectMake(passwordFieldX, passwordFieldY, fieldWidth, fieldHeight);
    
    // register button
    CGFloat const registerButtonX = emailFieldX;
    CGFloat const registerButtonY = viewHeight - fieldHeight;
    NSLog(@"registerButtonX: %f, registerButtonY: %f", registerButtonX, registerButtonY);
    _goToRegisterButton.frame = CGRectMake(registerButtonX, registerButtonY, fieldWidth, fieldHeight);
    
    // login button
    CGFloat const loginButtonX = emailFieldX;
    CGFloat const loginButtonY = registerButtonY - fieldHeight - 10;
    NSLog(@"loginButtonX: %f, loginButtonY: %f", loginButtonX, loginButtonY);
    _loginButton.frame = CGRectMake(loginButtonX, loginButtonY, fieldWidth, fieldHeight);
}

#pragma mark - User Actions

- (void)didTapLoginButton:(id)sender{
    NSLog(@"Tapped login button");
    if (_emailField.isFirstResponder || _passwordField.isFirstResponder) {
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for email field or password field");
    }
    [self loginUserWithEmail:_emailField.text password:_passwordField.text];
}

- (void)didTapGoToRegisterButton:(id)sender{
    NSLog(@"Tapped goToRegister button, moving to registration screen");
    if (_emailField.isFirstResponder || _passwordField.isFirstResponder) {
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for email field or password field");
    }
    [NavigationManager presentRegistrationScreenWithNavigationController:self.navigationController];
}

#pragma mark - Firebase Auth

- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password {
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Logged into account successfully");
            [self authenticatedTransition];
        } else {
            NSLog(@"Account login failed: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

- (void)authenticatedTransition {
    SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [NavigationManager presentLoggedInScreenWithSceneDelegate:sceneDelegate];
}

@end
