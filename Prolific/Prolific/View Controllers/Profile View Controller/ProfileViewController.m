//
//  ProfileViewController.m
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProfileViewController.h"

#import "BadgeCell.h"
#import "DAO.h"
@import Firebase;
#import "NavigationManager.h"
#import "UIColor+ProlificColors.h"
#import "ProfileView.h"
#import "ProjectCell.h"

#pragma mark - Interface

@interface ProfileViewController () <ProfileViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<Badge *> *badges;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray<Project *> *projects;

@end

#pragma mark - Implementation

@implementation ProfileViewController

#pragma mark - Initializer

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        _user = user;
        _badges = [_user.badges allValues];
    }
    return self;
}

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Profile";
    [super setupBackButton];
    
    __weak typeof (self) weakSelf = self;
    [self loadUserWithCompletion:^(NSError *error) {
        if (!error) {
            [self loadProjectsWithCompletion:^(NSError *error) {
                if (!error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        typeof(self) strongSelf = weakSelf;
                        if (strongSelf) {
                            [strongSelf setupCollectionView];
                        }
                    });
                }
            }];
        }
    }];
}

- (void)setupCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 0.3 * self.view.bounds.size.height);
    _layout.sectionHeadersPinToVisibleBounds = YES;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:_layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[ProfileView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"profileHeader"];
    [_collectionView registerClass:[ProjectCell class]
        forCellWithReuseIdentifier:@"projectCell"];
    [_collectionView registerClass:[BadgeCell class] forCellWithReuseIdentifier:@"badgeCell"];
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - Load data

- (void)loadUserWithCompletion:(void(^)(NSError *error))completion {
    __weak typeof (self) weakSelf = self;
    [_dao getUserWithId:_user.userId completion:^(User *user, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (user) {
            strongSelf.user = user;
            strongSelf.badges = [user.badges allValues];
        }
        completion(error);
    }];
}

- (void)loadProjectsWithCompletion:(void(^)(NSError *error))completion {
    __weak typeof (self) weakSelf = self;
    [_dao getAllCreatedProjectsforUserId:_user.userId completion:^(NSArray *projects, NSError *error) {
        if (projects) {
            weakSelf.projects = projects;
            completion(error);
        }
    }];
}

#pragma mark - ProfileViewDelegate Protocol

- (void)presentImagePicker:(UIImagePickerController *)imagePickerVC {
    [self presentViewController:imagePickerVC
                       animated:YES
                     completion:nil];
}

- (void)dismissImagePicker {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _projects.count;
    } else {
        return _badges.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ProjectCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell"
                                                                            forIndexPath:indexPath];
        cell.project = _projects[indexPath.item];
        cell.cellView.followButton.hidden = YES;
        [cell setNeedsLayout];
        return cell;
    } else {
        BadgeCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell"
                                                                          forIndexPath:indexPath];
        cell.badge = _badges[indexPath.item];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ProfileView *const profileHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"profileHeader" forIndexPath:indexPath];
        profileHeader.user = _user;
        profileHeader.dao = _dao;
        profileHeader.delegate = self;
        return profileHeader;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _layout.headerReferenceSize;
    } else {
        return CGSizeZero;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 6.0);
}

@end
