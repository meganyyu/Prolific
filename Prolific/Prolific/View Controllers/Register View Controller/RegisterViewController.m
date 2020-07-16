//
//  RegisterViewController.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RegisterViewController.h"

#import "DAO.h"

@import FirebaseAuth;
@import FirebaseFirestore;
#import "NavigationManager.h"
#import "SceneDelegate.h"
#import "User.h"

static NSString *const kDisplayNameKey = @"displayName";
static NSString *const kEmailKey = @"email";
static NSString *const kPasswordKey = @"password";
static NSString *const kUsernameKey = @"username";

@interface RegisterViewController ()

@property (nonatomic, strong) UIView *registerContentView;
@property (nonatomic, strong) UITextField *displayNameField;
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
    
    _displayNameField = [[UITextField alloc] init];
    _displayNameField.backgroundColor = [UIColor whiteColor];
    _displayNameField.placeholder = @"Name";
    _displayNameField.borderStyle = UITextBorderStyleRoundedRect;
    [_registerContentView addSubview:_displayNameField];
    
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
    CGFloat const viewHeight = boundsHeight * 0.6;
    CGFloat const viewX = center.x - viewWidth / 2;
    CGFloat const viewY = center.y - viewHeight / 2;
    NSLog(@"viewWidth: %f, viewHeight: %f, viewX: %f, viewY: %f", viewWidth, viewHeight, viewX, viewY);
    _registerContentView.frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);

    // displayName field
    CGFloat const fieldWidth = viewWidth * 0.75;
    CGFloat const fieldHeight = (viewHeight * 0.75) / 6.0;
    CGFloat const displayNameFieldX = _registerContentView.center.x - fieldWidth / 2;
    CGFloat const displayNameFieldY = 0;
    NSLog(@"fieldWidth: %f, fieldHeight: %f, displayNameFieldX: %f, displayNameFieldY: %f", fieldWidth, fieldHeight, displayNameFieldX, displayNameFieldY);
    _displayNameField.frame = CGRectMake(displayNameFieldX, displayNameFieldY, fieldWidth, fieldHeight);
    
    // username field
    CGFloat const usernameFieldX = displayNameFieldX;
    CGFloat const usernameFieldY = displayNameFieldY + fieldHeight;
    NSLog(@"usernameFieldX: %f, usernameFieldY: %f", usernameFieldX, usernameFieldY);
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
    [self resignFields];
    
    [self registerUserWithUsername:_usernameField.text email:_emailField.text password:_passwordField.text displayName:_displayNameField.text];
}

- (void)didTapReturnToLoginButton:(id)sender{
    NSLog(@"Tapped returnToLogin button, leaving registration screen");
    [self resignFields];
    
    [NavigationManager exitTopViewController:self.navigationController];
}

#pragma mark - New User Authentication

- (void)registerUserWithUsername:(NSString *)username
                           email:(NSString *)email
                        password:(NSString *)password
                     displayName: (NSString *)displayName {
    NSString *const fieldEntryError = [self validateFields];
    
    NSDictionary *const cleanedFields = [self getCleanedFields];
    
    if (fieldEntryError) {
        NSLog(@"%@", fieldEntryError);
    } else {
        [[FIRAuth auth] createUserWithEmail:cleanedFields[kEmailKey]
                                   password:cleanedFields[kPasswordKey]
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
            if (!error) {
                NSLog(@"Created account successfully, saving to Firestore...");
                
                DAO *const dao = [[DAO alloc] init];
                UserBuilder *const userBuilder = [[UserBuilder alloc] init];
                User *const newUser = [[[[[userBuilder
                                     withId:authResult.user.uid]
                                    withEmail:cleanedFields[kEmailKey]]
                                   withUsername:cleanedFields[kUsernameKey]]
                                  withDisplayName:cleanedFields[kDisplayNameKey]]
                                 build];
                if (!newUser) {
                    [dao saveUser:newUser];
                    [self authenticatedTransition];
                } else {
                    // FIXME: remove user from Firebase Auth if fails to save to Firestore
                    NSLog(@"Account creation failed, aborting.");
                }
            } else {
                NSLog(@"Account creation failed: %@", error.localizedDescription);
            }
        }];
    }
}

#pragma mark - Helper functions

- (void)resignFields {
    if (_displayNameField.isFirstResponder || _usernameField.isFirstResponder || _passwordField.isFirstResponder || _emailField.isFirstResponder) {
        [_displayNameField resignFirstResponder];
        [_usernameField resignFirstResponder];
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
        NSLog(@"Resigned first responder for all fields");
    }
}

/** Returns a dictionary of the cleaned data fields. */
- (NSDictionary *)getCleanedFields {
    NSString *const cleanedDisplayName = [_displayNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *const cleanedUsername = [_usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *const cleanedEmail = [_emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *const cleanedPassword = [_passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            cleanedDisplayName, kDisplayNameKey,
            cleanedUsername, kUsernameKey,
            cleanedEmail, kEmailKey,
            cleanedPassword, kPasswordKey, nil];
}

/** Check the fields and validate that the data is correct. If everything is correct, method returns nil. Otherwise, returns error message as a string. */
- (NSString *)validateFields {
    NSDictionary *cleanedFields = [self getCleanedFields];
    
    // check that all fields are filled in
    if ([cleanedFields[kDisplayNameKey] isEqualToString:@""] ||
        [cleanedFields[kUsernameKey] isEqualToString:@""] ||
        [cleanedFields[kEmailKey] isEqualToString:@""] ||
        [cleanedFields[kPasswordKey] isEqualToString:@""]) {
        return @"Please fill in all fields";
    }
    
    // check that password meets requirements
    NSPredicate *const passwordRequirements = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"];
    BOOL const isValidPassword = [passwordRequirements evaluateWithObject:cleanedFields[kPasswordKey]];
    if (!isValidPassword) {
        return @"Please make sure password is at least 8 characters, contains a special character and a number.";
    }
    
    return nil;
}

#pragma mark - Navigation

- (void)authenticatedTransition {
    SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [NavigationManager presentLoggedInScreenWithSceneDelegate:sceneDelegate];
}

@end
