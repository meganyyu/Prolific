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

@end

#pragma mark - Implementation

@implementation HomeViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    // collection view layout
    [self setupCollectionView];
    
    // Navigation customization
    self.navigationItem.title = @"Home";
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(didTapLogoutButton:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    [self setupProfileButton];
    
    
    [self loadProjects];
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
    NSLog(@"Tapped profile!");
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
    
    [NavigationManager presentProjectDetailsViewControllerForProject:_projectArray[indexPath.item] navigationController:self.navigationController];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 7.0);
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
