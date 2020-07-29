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
#import "NavigationManager.h"
#import "ProjectCell.h"
#import "Project.h"
#import "ProjectBuilder.h"
#import "UIColor+ProlificColors.h"

static NSString *const kProfileIconId = @"profile-icon";

#pragma mark - Interface

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *projectArray;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) User *currUser;

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
    
    
    [self loadProjects];
}

- (void)loadCurrentUser {
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    
    __weak typeof (self) weakSelf = self;
    [_dao getUserWithId:currUserId completion:^(User *user, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (user) {
            strongSelf.currUser = user;
        } else {
            NSLog(@"Error loading user: %@", error.localizedDescription);
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

    [self.view addSubview:_collectionView];
}

- (void)setupProfileButton {
    UIButton *const profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    profileButton.frame = CGRectMake(0, 0, 40, 40);
    [profileButton setImage:[UIImage imageNamed:kProfileIconId]
                forState:UIControlStateNormal];
    [profileButton addTarget:self
                      action:@selector(onTapProfile:)
            forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:profileButton];
}

#pragma mark - Load data

- (void)loadProjects {
    
    [_dao getAllProjectsWithCompletion:^(NSArray * _Nonnull projects, NSError * _Nonnull error) {
        if (projects) {
            self.projectArray = (NSMutableArray *) projects;
            
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.collectionView reloadData];
                }
            });
        } else {
            NSLog(@"Error retrieving projects: %@", error.localizedDescription);
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
    } else {
        NSLog(@"Error, user data not fully loaded.");
    }
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _projectArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell"
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
    
    [NavigationManager presentProjectDetailsViewControllerForProject:selectedProj navigationController:self.navigationController];
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
        NSLog(@"Error signing out: %@", signOutError);
        return;
    } else {
        NSLog(@"Successfully signed out.");
        SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        [NavigationManager presentLoggedOutScreenWithSceneDelegate:sceneDelegate];
    }
}

@end
