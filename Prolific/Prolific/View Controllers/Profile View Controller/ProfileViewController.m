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
#import "UIColor+ProlificColors.h"
#import "ProfileView.h"

@interface ProfileViewController () <ProfileViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Profile";
    [super setupBackButton];
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 0.3 * self.view.bounds.size.height);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[ProfileView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"profileHeader"];
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    
    [self.view addSubview:_collectionView];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 6.0);
}

@end
