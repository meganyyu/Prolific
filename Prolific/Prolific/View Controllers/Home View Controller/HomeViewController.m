//
//  ViewController.m
//  Prolific
//
//  Created by meganyu on 7/13/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "HomeViewController.h"

#import "NavigationManager.h"

#pragma mark - Interface

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

#pragma mark - Implementation

@implementation HomeViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

     UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"threadCell"];
    [_collectionView setBackgroundColor:[UIColor yellowColor]];

    [self.view addSubview:_collectionView];
    
    // Navigation customization
    self.navigationItem.title = @"Home";
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(didTapLogoutButton:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
}

#pragma mark - User actions

- (void)didTapLogoutButton:(UIBarButtonItem *)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    [NavigationManager presentLoggedOutScreenWithSceneDelegate:sceneDelegate];
    
    //TODO: logout of Firebase user account
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"threadCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}


@end
