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
#import "FeedCell.h"
@import Firebase;
#import "MenuBar.h"
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
@property (nonatomic, strong) MenuBar *menuBar;
@property (nonatomic, strong) ProfileView *profileHeader;
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
    
    [self setupProfileHeader];
    [self setupMenuBar];
    [self setupCollectionView];
    
    __weak typeof (self) weakSelf = self;
    [self loadUserWithCompletion:^(NSError *error) {
        if (!error) {
            [self loadProjectsWithCompletion:^(NSError *error) {
                if (!error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        typeof(self) strongSelf = weakSelf;
                        if (strongSelf) {
                            // load data
                        }
                    });
                }
            }];
        }
    }];
}

- (void)setupProfileHeader {
    CGFloat const headerWidth = self.view.bounds.size.width;
    CGFloat const headerHeight = 0.35 * self.view.bounds.size.height;
    CGFloat const headerX = 0;
    CGFloat const headerY = self.navigationController.navigationBar.frame.size.height;
    
    _profileHeader = [[ProfileView alloc] initWithFrame:CGRectMake(headerX, headerY, headerWidth, headerHeight)];
    _profileHeader.user = _user;
    _profileHeader.dao = _dao;
    _profileHeader.delegate = self;
    
    [self.view addSubview:_profileHeader];
}

- (void)setupMenuBar {
    CGFloat const barWidth = self.view.bounds.size.width;
    CGFloat const barHeight = 50;
    CGFloat const barX = 0;
    CGFloat const barY = _profileHeader.bounds.size.height;
    
    _menuBar = [[MenuBar alloc] initWithFrame:CGRectMake(barX, barY, barWidth, barHeight)];
    _menuBar.viewController = self;
    [self.view addSubview:_menuBar];
}

- (void)setupCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.minimumLineSpacing = 0;
    
    CGFloat const viewWidth = self.view.bounds.size.width;
    CGFloat const viewHeight = self.view.bounds.size.height - _menuBar.bounds.size.height - _profileHeader.bounds.size.height;
    CGFloat const viewX = 0;
    CGFloat const viewY = _menuBar.frame.origin.y + _menuBar.bounds.size.height;
    CGRect const frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame
                                         collectionViewLayout:_layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[FeedCell class]
        forCellWithReuseIdentifier:@"feedCell"];
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    
    _collectionView.pagingEnabled = YES;
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

#pragma mark - Scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_menuBar moveHorizontalBarToX:scrollView.contentOffset.x / 2];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger const index = targetContentOffset->x / self.view.frame.size.width;
    NSIndexPath *const indexPath = [NSIndexPath indexPathForItem:(NSInteger) index inSection:0];
    [_menuBar.collectionView selectItemAtIndexPath:indexPath
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)scrollToMenuIndex:(NSInteger)menuIndex {
    NSIndexPath *const indexPath = [NSIndexPath indexPathForItem:menuIndex inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionNone
                                    animated:YES];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"feedCell"
                                                                     forIndexPath:indexPath];
    NSArray *const colors = @[[UIColor ProlificBlue1Color], [UIColor ProlificBlue2Color]];
    cell.backgroundColor = colors[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

@end
