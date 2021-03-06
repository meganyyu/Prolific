//
//  FavoritesViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FavoritesViewController.h"

#import "DAO.h"
@import FirebaseAuth;
#import "NavigationManager.h"
#import "ProjectCell.h"
#import "Project.h"
#import "ProjectBuilder.h"
#import "UIColor+ProlificColors.h"
#import "User.h"

#pragma mark - Interface

@interface FavoritesViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *projectArray;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) User *currUser;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

#pragma mark - Implementation

@implementation FavoritesViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    [self loadCurrentUser];
    
    [self setupCollectionView];
    
    self.navigationItem.title = @"Favorites";
    
    [self loadProjects];
    
    [self setupRefreshControl];
}

- (void)setupRefreshControl {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(loadProjects)
              forControlEvents:UIControlEventValueChanged];
    [_collectionView insertSubview:_refreshControl
                           atIndex:0];
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
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    
    [self.view addSubview:_collectionView];
}

#pragma mark - Load data

- (void)loadCurrentUser {
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    
    __weak typeof (self) weakSelf = self;
    [_dao getUserWithId:currUserId completion:^(User *user, NSError *error) {
        if (user) {
            weakSelf.currUser = user;
        }
    }];
}

- (void)loadProjects {
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    
    __weak typeof(self) weakSelf = self;
    [_dao getAllFollowedProjectsforUserId:currUserId completion:^(NSArray *projects, NSError * error) {
        if (projects) {
            weakSelf.projectArray = (NSMutableArray *) projects;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof (self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.collectionView reloadData];
                }
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof (self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf.refreshControl endRefreshing];
            }
        });
    }];
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

@end
