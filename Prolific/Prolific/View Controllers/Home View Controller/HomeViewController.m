//
//  ViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "HomeViewController.h"

#import "DAO.h"
@import FirebaseAuth;
#import "FloatingActionButton.h"
#import "NavigationManager.h"
#import "ProjectCell.h"
#import "Project.h"
#import "ProjectBuilder.h"
#import "ProlificErrorLogger.h"
#import "UIColor+ProlificColors.h"
#import "User.h"

#pragma mark - Constants

static NSString *const kProfileIconId = @"profile-icon";
static NSString *const kCreateProjectIconId = @"create-project-icon";

#pragma mark - Interface

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CreateProjectViewControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FloatingActionButton *createButton;
@property (nonatomic, strong) User *currUser;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) NSMutableArray *projectArray;

@end

#pragma mark - Implementation

@implementation HomeViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    [self loadCurrentUser];
    
    [self setupCollectionView];
    
    self.navigationItem.title = @"Home";
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(didTapLogoutButton:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    [self setupProfileButton];
    [self setupCreateButton];
    
    [self loadProjects];
}

- (void)loadCurrentUser {
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    
    __weak typeof (self) weakSelf = self;
    [_dao getUserWithId:currUserId completion:^(User *user, NSError *error) {
        if (user) {
            weakSelf.currUser = user;
        }
    }];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[ProjectCell class]
        forCellWithReuseIdentifier:@"projectCell"];
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    [_collectionView setAllowsMultipleSelection:NO];
    
    [self.view addSubview:_collectionView];
}

- (void)setupCreateButton {
    CGFloat const boundsWidth = CGRectGetWidth(self.view.bounds);
    CGFloat const boundsHeight = CGRectGetHeight(self.view.bounds);

    CGFloat const buttonMargin = boundsWidth * 0.05;
    CGFloat const buttonWidth = 60;
    CGFloat const buttonHeight = 60;
    CGFloat const buttonX = boundsWidth - buttonWidth - buttonMargin;
    CGFloat const buttonY = boundsHeight - self.tabBarController.tabBar.frame.size.height - buttonHeight - buttonMargin;
    
    _createButton = [FloatingActionButton buttonWithType:UIButtonTypeRoundedRect];
    _createButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    [_createButton setImage:[[UIImage imageNamed:kCreateProjectIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState:UIControlStateNormal];
    [_createButton addTarget:self
                      action:@selector(onTapCreateProject:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_createButton];
}

- (void)setupProfileButton {
    UIButton *const profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    profileButton.frame = CGRectMake(0, 0, 40, 40);
    [profileButton setImage:[[UIImage imageNamed:kProfileIconId] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                   forState:UIControlStateNormal];
    [profileButton addTarget:self
                      action:@selector(onTapProfile:)
            forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:profileButton];
}

#pragma mark - Load data

- (void)loadProjects {
    __weak typeof(self) weakSelf = self;
    [_dao getAllProjectsWithCompletion:^(NSArray * _Nonnull projects, NSError * _Nonnull error) {
        if (projects) {
            weakSelf.projectArray = (NSMutableArray *) projects;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof (self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.collectionView reloadData];
                }
            });
        }
    }];
}

#pragma mark - User actions

- (void)didTapLogoutButton:(UIBarButtonItem *)sender {
    [self logoutUser];
}

- (void)onTapProfile:(id)sender {
    if (_currUser) {
        [NavigationManager presentProfileViewControllerForUser:_currUser navigationController:self.navigationController];
    }
}

- (void)onTapCreateProject:(id)sender {
    [NavigationManager presentCreateProjectViewControllerfromViewController:self];
}

#pragma mark - CreateProjectViewControllerDelegate Protocol

- (void)didCreateProject:(Project *)project {
    [_projectArray insertObject:project atIndex:0];
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _projectArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell"
                                                                  forIndexPath:indexPath];
    cell.project = _projectArray[indexPath.item];
    cell.cellView.followButton.hidden = YES;
    return cell;
}

#pragma mark - UICollectionViewDelegate Protocol

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Project *const selectedProj = _projectArray[indexPath.item];
    
    [FIRAnalytics logEventWithName:kFIREventSelectContent
                        parameters:@{
                            kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", selectedProj.projectId],
                            kFIRParameterItemName:selectedProj.name,
                            kFIRParameterContentType:@"project"
                        }];
    
    [NavigationManager presentProjectDetailsViewControllerForProject:selectedProj
                                                      forCurrentUser:_currUser
                                                navigationController:self.navigationController];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 6.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return collectionView.frame.size.height * 0.05;
}

#pragma mark - Firebase Auth

- (void)logoutUser {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        [ProlificErrorLogger logErrorWithMessage:[NSString stringWithFormat:@"Error signing out: %@", signOutError]
                                shouldRaiseAlert:YES];
        return;
    } else {
        SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        [NavigationManager presentLoggedOutScreenWithSceneDelegate:sceneDelegate];
    }
}

@end
