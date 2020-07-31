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
#import "UIColor+ProlificColors.h"
#import "RoundRanker.h"

#pragma mark - Interface

@interface SubmissionsViewController () <SnippetCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) NSMutableArray *snippetArray;

@end

#pragma mark Implementation

@implementation SubmissionsViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Round Submissions";
    [super setupBackButton];
    
    [self setupCollectionView];
    
    [self loadSubmissions];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[SnippetCell class]
        forCellWithReuseIdentifier:@"snippetCell"];
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark - User Actions

- (void)onTapBack:(id)sender{
    [NavigationManager exitTopViewControllerWithUpdatedProject:_project navigationController:self.navigationController];
}

#pragma mark - Load submissions

- (void)loadSubmissions {
    __weak typeof (self) weakSelf = self;
    [_dao getAllSubmissionsforRoundId:_round.roundId
                            projectId:_project.projectId
                           completion:^(NSMutableArray * _Nonnull submissions, NSError * _Nonnull error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (submissions) {
            strongSelf.snippetArray = (NSMutableArray *) submissions;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof (self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.collectionView reloadData];
                }
            });
        } else {
            NSLog(@"Error retrieving submissions: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - SnippetCellDelegate Protocol

- (void)didVote:(Snippet *)snippet {
    Round *const round = [[[[[RoundBuilder alloc] initWithRound:_round]
                            updateExistingSubmissionWithSubmission:snippet]
                           updateRoundVoteCountBy:(snippet.userVoted ? 1 : -1) forUser:_currUser]
                          build];
    Project *const project = [[[[ProjectBuilder alloc] initWithProject:_project]
                               updateLatestRound:round]
                              build];
    
    __weak typeof (self) weakSelf = self;
    [_dao updateExistingSnippet:snippet
                   forProjectId:_project.projectId
                       forRound:_round
                     completion:^(NSError * _Nonnull error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (error) {
            NSLog(@"Error updating firebase with vote: %@", error.localizedDescription);
        } else {
            [strongSelf.dao updateExistingRound:round
                                   forProjectId:strongSelf.project.projectId
                                     completion:^(NSError * _Nonnull error) {
                __strong typeof (weakSelf) strongSelf = weakSelf;
                if (strongSelf == nil) return;
                
                if (error) {
                    NSLog(@"Error updating firebase with vote: %@", error.localizedDescription);
                } else {
                    strongSelf.round = round;
                    strongSelf.project = project;
                }
            }];
        }
    }];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _snippetArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SnippetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"snippetCell" forIndexPath:indexPath];
    cell.snippet = _snippetArray[indexPath.item];
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate Protocol

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 7.0);
}

@end
