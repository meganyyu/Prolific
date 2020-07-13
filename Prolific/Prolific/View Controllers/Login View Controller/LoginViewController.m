//
//  LoginViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "LoginViewController.h"

#pragma mark - Interface

@interface LoginViewController ()

@property (nonatomic, strong) UIView *loginContentView;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;

@end

#pragma mark - Implementation

@implementation LoginViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect const frame = self.view.frame;
    CGFloat const frameWidth = CGRectGetWidth(frame);
    CGFloat const frameHeight = CGRectGetHeight(frame);
    CGPoint const center = self.view.center;
    NSLog(@"frameWidth: %f, frameHeight: %f, centerX: %f, centerY: %f", frameWidth, frameHeight, center.x, center.y);
    
    CGFloat const ratio1 = 0.5;
    CGFloat const ratio2 = 0.75;
    
    // login content view
    CGFloat const viewWidth = frameWidth;
    CGFloat const viewHeight = frameHeight * ratio1;
    CGFloat const viewX = center.x - viewWidth / 2;
    CGFloat const viewY = center.y - viewHeight / 2;
    NSLog(@"viewWidth: %f, viewHeight: %f, viewX: %f, viewY: %f", viewWidth, viewHeight, viewX, viewY);
    
    _loginContentView = [[UIView alloc] init];
    _loginContentView.frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);
    _loginContentView.backgroundColor = [UIColor grayColor];
    
    // username field
    CGFloat const fieldWidth = viewWidth * ratio2;
    CGFloat const fieldHeight = (viewHeight * ratio1) / 3;
    CGFloat const usernameFieldX = _loginContentView.center.x - fieldWidth / 2;
    CGFloat const usernameFieldY = (viewHeight - fieldHeight) / 2;
    NSLog(@"fieldWidth: %f, fieldHeight: %f, usernameFieldX: %f, usernameFieldY: %f", fieldWidth, fieldHeight, usernameFieldX, usernameFieldY);
    
    _usernameField = [[UITextField alloc] init];
    _usernameField.frame = CGRectMake(usernameFieldX, usernameFieldY, fieldWidth, fieldHeight);
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.placeholder = @"Username";
    _usernameField.borderStyle = UITextBorderStyleRoundedRect;
    
    // password field
    CGFloat const passwordFieldX = usernameFieldX;
    CGFloat const passwordFieldY = usernameFieldY + fieldHeight;
    NSLog(@"passwordFieldX: %f, passwordFieldY: %f", passwordFieldX, passwordFieldY);
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.frame = CGRectMake(passwordFieldX, passwordFieldY, fieldWidth, fieldHeight);
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.placeholder = @"Password";
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    
    // login button
    CGFloat const loginButtonX = usernameFieldX;
    CGFloat const loginButtonY = passwordFieldY + fieldHeight;
    NSLog(@"loginButtonX: %f, loginButtonY: %f", loginButtonX, loginButtonY);
    
    _loginButton = [[UIButton alloc] init];
    _loginButton.frame = CGRectMake(loginButtonX, loginButtonY, fieldWidth, fieldHeight);
    _loginButton.backgroundColor = [UIColor blueColor];
    [_loginButton setTitle:@"Login" forState:normal]; // what is normal?
    _loginButton.tintColor = [UIColor whiteColor];
    _loginButton.layer.cornerRadius = 5;
    _loginButton.clipsToBounds = YES;
    
    // setup login content view
    
    [_loginContentView addSubview:_usernameField];
    [_loginContentView addSubview:_passwordField];
    [_loginContentView addSubview:_loginButton];
    
    // setup overall view
    
    [self.view addSubview:_loginContentView];
}



@end
