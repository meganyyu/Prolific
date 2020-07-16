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
#import "ProjectPreviewCell.h"
#import "Project.h"
#import "ProjectBuilder.h"

#pragma mark - Interface

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *projectArray;

@end

#pragma mark - Implementation

@implementation HomeViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    [_collectionView registerClass:[ProjectPreviewCell class] forCellWithReuseIdentifier:@"projectCell"];
    [_collectionView setBackgroundColor:[UIColor grayColor]];

    [self.view addSubview:_collectionView];
    
    // Navigation customization
    self.navigationItem.title = @"Home";
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(didTapLogoutButton:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    [self loadProjects];
}

#pragma mark - Load data

- (void)loadProjects {
    DAO *dao = [[DAO alloc] init];
    [dao getAllProjectsWithCompletion:^(NSArray * _Nonnull projects, NSError * _Nonnull error) {
        if (projects) {
            self.projectArray = projects;
            
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

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _projectArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell" forIndexPath:indexPath];
    cell.project = _projectArray[indexPath.item];
    NSLog(@"Getting cell with project name: %@", cell.project.name);
    return cell;
}

#pragma mark - UICollectionViewDelegate Protocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [NavigationManager presentProjectDetailsViewControllerWithNavigationController:self.navigationController];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
