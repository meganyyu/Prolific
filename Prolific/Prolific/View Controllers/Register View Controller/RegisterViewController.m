//
//  RegisterViewController.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RegisterViewController.h"

@import Firebase;
#import "NavigationManager.h"
#import "SceneDelegate.h"

@interface RegisterViewController ()

@property (nonatomic, strong) UIView *registerContentView;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *returnToLoginButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _registerContentView = [[UIView alloc] init];
    _registerContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_registerContentView];
    
    _usernameField = [[UITextField alloc] init];
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.placeholder = @"Username";
    _usernameField.borderStyle = UITextBorderStyleRoundedRect;
    [_registerContentView addSubview:_usernameField];
    
    _emailField = [[UITextField alloc] init];
    _emailField.backgroundColor = [UIColor whiteColor];
    _emailField.placeholder = @"Email";
    _emailField.borderStyle = UITextBorderStyleRoundedRect;
    [_registerContentView addSubview:_emailField];
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.placeholder = @"Password";
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    [_registerContentView addSubview:_passwordField];
    
    _registerButton = [[UIButton alloc] init];
    _registerButton.backgroundColor = [UIColor blueColor];
    [_registerButton setTitle:@"Sign Up" forState:normal];
    _registerButton.tintColor = [UIColor whiteColor];
    _registerButton.layer.cornerRadius = 5;
    _registerButton.clipsToBounds = YES;
    [_registerContentView addSubview:_registerButton];
    [_registerButton addTarget:self action:@selector(didTapRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _returnToLoginButton = [[UIButton alloc] init];
    _returnToLoginButton.backgroundColor = [UIColor systemRedColor];
    [_returnToLoginButton setTitle:@"Cancel" forState:normal];
    _returnToLoginButton.tintColor = [UIColor whiteColor];
    _returnToLoginButton.layer.cornerRadius = 5;
    _returnToLoginButton.clipsToBounds = YES;
    [_registerContentView addSubview:_returnToLoginButton];
    [_returnToLoginButton addTarget:self action:@selector(didTapReturnToLoginButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGPoint const center = self.view.center;
    NSLog(@"frameWidth: %f, frameHeight: %f, centerX: %f, centerY: %f", boundsWidth, boundsHeight, center.x, center.y);
    
    // login content view
    CGFloat const viewWidth = boundsWidth;
    CGFloat const viewHeight = boundsHeight * 0.5;
    CGFloat const viewX = center.x - viewWidth / 2;
    CGFloat const viewY = center.y - viewHeight / 2;
    NSLog(@"viewWidth: %f, viewHeight: %f, viewX: %f, viewY: %f", viewWidth, viewHeight, viewX, viewY);
    _registerContentView.frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);

    // username field
    CGFloat const fieldWidth = viewWidth * 0.75;
    CGFloat const fieldHeight = (viewHeight * 0.75) / 5.0;
    CGFloat const usernameFieldX = _registerContentView.center.x - fieldWidth / 2;
    CGFloat const usernameFieldY = 0;
    NSLog(@"fieldWidth: %f, fieldHeight: %f, usernameFieldX: %f, usernameFieldY: %f", fieldWidth, fieldHeight, usernameFieldX, usernameFieldY);
    _usernameField.frame = CGRectMake(usernameFieldX, usernameFieldY, fieldWidth, fieldHeight);
    
    // email field
    CGFloat const emailFieldX = usernameFieldX;
    CGFloat const emailFieldY = usernameFieldY + fieldHeight;
    NSLog(@"emailFieldX: %f, emailFieldY: %f", emailFieldX, emailFieldY);
    _emailField.frame = CGRectMake(emailFieldX, emailFieldY, fieldWidth, fieldHeight);
    
    // password field
    CGFloat const passwordFieldX = usernameFieldX;
    CGFloat const passwordFieldY = emailFieldY + fieldHeight;
    NSLog(@"passwordFieldX: %f, passwordFieldY: %f", passwordFieldX, passwordFieldY);
    _passwordField.frame = CGRectMake(passwordFieldX, passwordFieldY, fieldWidth, fieldHeight);
    
    // login button
    CGFloat const loginButtonX = usernameFieldX;
    CGFloat const loginButtonY = viewHeight - fieldHeight;
    NSLog(@"loginButtonX: %f, loginButtonY: %f", loginButtonX, loginButtonY);
    _returnToLoginButton.frame = CGRectMake(loginButtonX, loginButtonY, fieldWidth, fieldHeight);
    
    // registration button
    CGFloat const registerButtonX = usernameFieldX;
    CGFloat const registerButtonY = loginButtonY - fieldHeight - 10;
    NSLog(@"registerButtonX: %f, registerButtonY: %f", registerButtonX, registerButtonY);
    _registerButton.frame = CGRectMake(registerButtonX, registerButtonY, fieldWidth, fieldHeight);
}

#pragma mark - User Actions

- (void)didTapRegisterButton:(id)sender{
    NSLog(@"Tapped sign up button");
    if (_usernameField.isFirstResponder || _passwordField.isFirstResponder || _emailField.isFirstResponder) {
        [_usernameField resignFirstResponder];
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for all fields");
    }
    // TODO: When a new user signs up, complete any new account validation steps that your app requires, such as verifying that the new account's password was correctly typed and meets your complexity requirements.
    [self registerUserWithEmail:_emailField.text password:_passwordField.text];
}

- (void)didTapReturnToLoginButton:(id)sender{
    NSLog(@"Tapped returnToLogin button, leaving registration screen");
    if (_usernameField.isFirstResponder || _passwordField.isFirstResponder || _emailField.isFirstResponder) {
        [_usernameField resignFirstResponder];
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for all fields");
    }
    [NavigationManager exitTopViewController:self.navigationController];
}

#pragma mark - Firebase Auth

- (void)registerUserWithEmail:(NSString *)email password:(NSString *)password {
    [[FIRAuth auth] createUserWithEmail:email
                               password:password
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Created account successfully");
            [self authenticatedTransition];
        } else {
            NSLog(@"Account creation failed: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

- (void)authenticatedTransition {
    SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [NavigationManager presentLoggedInScreenWithSceneDelegate:sceneDelegate];
}


@end
