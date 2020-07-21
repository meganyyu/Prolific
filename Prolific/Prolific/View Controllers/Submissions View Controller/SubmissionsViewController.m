//
//  SubmissionsViewController.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SubmissionsViewController.h"

#import "DAO.h"
@import FirebaseAuth;
#import "NavigationManager.h"
#import "SnippetCell.h"

@interface SubmissionsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) NSMutableArray *snippetArray;

@end

@implementation SubmissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // collection view layout
    [self setupCollectionView];
        
    // Navigation customization
    self.navigationItem.title = @"Round Submissions";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onTapBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self loadSubmissions];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[SnippetCell class] forCellWithReuseIdentifier:@"snippetCell"];
    [_collectionView setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:_collectionView];

}

#pragma mark - Load submissions

- (void)loadSubmissions {
    [_dao getAllSubmissionsforRoundId:_round.roundId projectId:_projectId completion:^(NSMutableArray * _Nonnull submissions, NSError * _Nonnull error) {
        if (submissions) {
            self.snippetArray = (NSMutableArray *) submissions;
            
            __weak typeof(self) weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.collectionView reloadData];
                }
            });
        } else {
            NSLog(@"Error retrieving submissions: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - User Actions

- (void)onTapBack:(id)sender{
    [NavigationManager exitTopViewController:self.navigationController];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _snippetArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SnippetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"snippetCell" forIndexPath:indexPath];
    cell.snippet = _snippetArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate Protocol

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 7.0);
}

@end
