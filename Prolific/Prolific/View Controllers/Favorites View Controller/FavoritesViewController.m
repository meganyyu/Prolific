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

#pragma mark - Interface

@interface FavoritesViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *projectArray;
@property (nonatomic, strong) DAO *dao;

@end

#pragma mark - Implementation

@implementation FavoritesViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    // collection view layout
    [self setupCollectionView];
    
    // Navigation customization
    self.navigationItem.title = @"Favorites";
    
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

#pragma mark - Load data

- (void)loadProjects {
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    
    [_dao getAllFollowedProjectsforUserId:currUserId completion:^(NSArray *projects, NSError * error) {
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

@end
