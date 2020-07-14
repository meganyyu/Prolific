//
//  LoginViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "LoginViewController.h"

@import Firebase;
#import "NavigationManager.h"
#import "SceneDelegate.h"

#pragma mark - Interface

@interface LoginViewController ()

@property (nonatomic, strong) UIView *loginContentView;
@property (nonatomic, strong) UITextField *usernameField;
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
    _loginContentView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_loginContentView];
    
    _usernameField = [[UITextField alloc] init];
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.placeholder = @"Username";
    _usernameField.borderStyle = UITextBorderStyleRoundedRect;
    [_loginContentView addSubview:_usernameField];
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.placeholder = @"Password";
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
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

    // username field
    CGFloat const fieldWidth = viewWidth * 0.75;
    CGFloat const fieldHeight = (viewHeight * 0.75) / 4;
    CGFloat const usernameFieldX = _loginContentView.center.x - fieldWidth / 2;
    CGFloat const usernameFieldY = 0;
    NSLog(@"fieldWidth: %f, fieldHeight: %f, usernameFieldX: %f, usernameFieldY: %f", fieldWidth, fieldHeight, usernameFieldX, usernameFieldY);
    _usernameField.frame = CGRectMake(usernameFieldX, usernameFieldY, fieldWidth, fieldHeight);
    
    // password field
    CGFloat const passwordFieldX = usernameFieldX;
    CGFloat const passwordFieldY = usernameFieldY + fieldHeight;
    NSLog(@"passwordFieldX: %f, passwordFieldY: %f", passwordFieldX, passwordFieldY);
    _passwordField.frame = CGRectMake(passwordFieldX, passwordFieldY, fieldWidth, fieldHeight);
    
    // login button
    CGFloat const loginButtonX = usernameFieldX;
    CGFloat const loginButtonY = passwordFieldY + fieldHeight + (viewHeight * 0.25);
    NSLog(@"loginButtonX: %f, loginButtonY: %f", loginButtonX, loginButtonY);
    _loginButton.frame = CGRectMake(loginButtonX, loginButtonY, fieldWidth, fieldHeight);
    
    // register button
    CGFloat const registerButtonX = usernameFieldX;
    CGFloat const registerButtonY = loginButtonY + fieldHeight;
    NSLog(@"registerButtonX: %f, registerButtonY: %f", registerButtonX, registerButtonY);
    _goToRegisterButton.frame = CGRectMake(registerButtonX, registerButtonY, fieldWidth, fieldHeight);
}

#pragma mark - User Actions

- (void)didTapLoginButton:(id)sender{
    NSLog(@"Tapped login button");
    if (_usernameField.isFirstResponder || _passwordField.isFirstResponder) {
        [_usernameField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for  username field or password field");
    }
    [self loginUserWithEmail:_usernameField.text password:_passwordField.text];
}

- (void)didTapGoToRegisterButton:(id)sender{
    NSLog(@"Tapped goToRegister button, moving to registration screen");
    if (_usernameField.isFirstResponder || _passwordField.isFirstResponder) {
        [_usernameField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for  username field or password field");
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
