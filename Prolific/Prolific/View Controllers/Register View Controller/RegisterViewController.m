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
#import "ProlificErrorLogger.h"
#import "SceneDelegate.h"
#import "UIColor+ProlificColors.h"
#import "UnderlinedTextField.h"
#import "User.h"

#pragma mark - Constants

static NSString *const kDisplayNameKey = @"displayName";
static NSString *const kEmailKey = @"email";
static NSString *const kPasswordKey = @"password";
static NSString *const kUsernameKey = @"username";
static NSString *const kMainLogoIconId = @"main-logo-primary";

#pragma mark - Interface

@interface RegisterViewController ()

@property (nonatomic, strong) UnderlinedTextField *displayNameField;
@property (nonatomic, strong) UnderlinedTextField *emailField;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIImageView *logoIconView;
@property (nonatomic, strong) UnderlinedTextField *passwordField;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIView *registerContentView;
@property (nonatomic, strong) UIButton *returnToLoginButton;
@property (nonatomic, strong) UnderlinedTextField *usernameField;

@end

#pragma mark - Implementation

@implementation RegisterViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _registerContentView = [[UIView alloc] init];
    _registerContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_registerContentView];
    
    _logoIconView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:kMainLogoIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_registerContentView addSubview:_logoIconView];
    
    _displayNameField = [[UnderlinedTextField alloc] init];
    _displayNameField.placeholder = @"Name";
    [_registerContentView addSubview:_displayNameField];
    
    _usernameField = [[UnderlinedTextField alloc] init];
    _usernameField.placeholder = @"Username";
    [_registerContentView addSubview:_usernameField];
    
    _emailField = [[UnderlinedTextField alloc] init];
    _emailField.placeholder = @"Email";
    [_registerContentView addSubview:_emailField];
    
    _passwordField = [[UnderlinedTextField alloc] init];
    _passwordField.placeholder = @"Password";
    _passwordField.secureTextEntry = YES;
    [_registerContentView addSubview:_passwordField];
    
    _registerButton = [[UIButton alloc] init];
    _registerButton.backgroundColor = [UIColor ProlificPrimaryBlueColor];
    [_registerButton setTitle:@"Sign Up" forState:normal];
    _registerButton.tintColor = [UIColor whiteColor];
    _registerButton.layer.cornerRadius = 5;
    _registerButton.clipsToBounds = YES;
    [_registerContentView addSubview:_registerButton];
    [_registerButton addTarget:self action:@selector(didTapRegisterButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    _returnToLoginButton = [[UIButton alloc] init];
    _returnToLoginButton.backgroundColor = [UIColor ProlificRedColor];
    [_returnToLoginButton setTitle:@"Cancel" forState:normal];
    _returnToLoginButton.tintColor = [UIColor whiteColor];
    _returnToLoginButton.layer.cornerRadius = 5;
    _returnToLoginButton.clipsToBounds = YES;
    [_registerContentView addSubview:_returnToLoginButton];
    [_returnToLoginButton addTarget:self action:@selector(didTapReturnToLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _errorLabel = [[UILabel alloc] init];
    _errorLabel.textColor = [UIColor ProlificRedColor];
    _errorLabel.textAlignment = NSTextAlignmentCenter;
    _errorLabel.numberOfLines = 0;
    [_registerContentView addSubview:_errorLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGPoint const center = self.view.center;
    
    // register content view
    _registerContentView.frame = self.view.frame;;

    // logo icon
    CGFloat const logoWidth = 110;
    CGFloat const logoHeight = 110;
    CGFloat const logoX = center.x - logoWidth / 2;
    CGFloat const logoY = 0.1 * boundsHeight;
    _logoIconView.frame = CGRectMake(logoX, logoY, logoWidth, logoHeight);
    
    
    CGFloat const fieldWidth = boundsWidth * 0.75;
    CGFloat const fieldHeight = 70;
    CGFloat const fieldX = center.x - fieldWidth / 2;
    
    // displayName field
    CGFloat const displayNameFieldY = logoY + logoHeight + 20;
    _displayNameField.frame = CGRectMake(fieldX, displayNameFieldY, fieldWidth, fieldHeight);
    
    // username field
    CGFloat const usernameFieldY = displayNameFieldY + fieldHeight + 5;
    _usernameField.frame = CGRectMake(fieldX, usernameFieldY, fieldWidth, fieldHeight);
    
    // email field
    CGFloat const emailFieldY = usernameFieldY + fieldHeight + 5;
    _emailField.frame = CGRectMake(fieldX, emailFieldY, fieldWidth, fieldHeight);
    
    // password field
    CGFloat const passwordFieldY = emailFieldY + fieldHeight + 5;
    _passwordField.frame = CGRectMake(fieldX, passwordFieldY, fieldWidth, fieldHeight);
    
    // error label
    CGFloat const errorLabelY = 0.85 * boundsHeight;
    _errorLabel.alpha = 0;
    _errorLabel.frame = CGRectMake(fieldX, errorLabelY, fieldWidth, fieldHeight);
    
    // login button
    CGFloat const loginButtonY = errorLabelY - fieldHeight - 10;
    _returnToLoginButton.frame = CGRectMake(fieldX, loginButtonY, fieldWidth, fieldHeight);
    
    // registration button
    CGFloat const registerButtonY = loginButtonY - fieldHeight - 10;
    _registerButton.frame = CGRectMake(fieldX, registerButtonY, fieldWidth, fieldHeight);
}

#pragma mark - User Actions

- (void)didTapRegisterButton:(id)sender{
    [self resignFields];
    
    [self registerUserWithUsername:_usernameField.text email:_emailField.text password:_passwordField.text displayName:_displayNameField.text];
}

- (void)didTapReturnToLoginButton:(id)sender{
    [self resignFields];
    
    [NavigationManager exitTopViewController:self.navigationController];
}

#pragma mark - New User Authentication

- (void)registerUserWithUsername:(NSString *)username
                           email:(NSString *)email
                        password:(NSString *)password
                     displayName: (NSString *)displayName {
    NSString *const fieldEntryError = [self validateFields];
    
    if (fieldEntryError) {
        [self showError:fieldEntryError];
    } else {
        [self hideError];
        
        NSDictionary *const cleanedFields = [self getCleanedFields];
        
        [[FIRAuth auth] createUserWithEmail:cleanedFields[kEmailKey]
                                   password:cleanedFields[kPasswordKey]
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
            if (!error) {
                DAO *const dao = [[DAO alloc] init];
                UserBuilder *const userBuilder = [[UserBuilder alloc] init];
                User *const newUser = [[[[[userBuilder
                                     withId:authResult.user.uid]
                                    withEmail:cleanedFields[kEmailKey]]
                                   withUsername:cleanedFields[kUsernameKey]]
                                  withDisplayName:cleanedFields[kDisplayNameKey]]
                                 build];
                if (!newUser) {
                    [dao saveUser:newUser completion:^(NSError *error) {
                        if (!error) {
                            [self authenticatedTransition];
                        }
                    }];
                } else {
                    // FIXME: remove user from Firebase Auth if fails to save to Firestore
                    [ProlificErrorLogger logErrorWithMessage:@"Account creation failed, aborting."
                                            shouldRaiseAlert:YES];
                }
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
    if (_displayNameField.isFirstResponder || _usernameField.isFirstResponder || _passwordField.isFirstResponder || _emailField.isFirstResponder) {
        [_displayNameField resignFirstResponder];
        [_usernameField resignFirstResponder];
        [_emailField resignFirstResponder];
        [_passwordField resignFirstResponder];
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
        return @"Please make sure password is at least 8 characters, contains a special character ($, @, #, !, %, *, ?, or &) and a number.";
    }
    
    return nil;
}

#pragma mark - Navigation

- (void)authenticatedTransition {
    SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [NavigationManager presentLoggedInScreenWithSceneDelegate:sceneDelegate];
}

@end
