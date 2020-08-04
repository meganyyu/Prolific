//
//  ProjectDetailsViewController.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectDetailsViewController.h"

#import "TextCell.h"
#import "DAO.h"
#import "NavigationManager.h"
#import "ComposeSnippetViewController.h"
#import "ProjectCell.h"
#import "ProjectUpdateManager.h"
#import "RoundCell.h"
#import "UIColor+ProlificColors.h"
#import "UserEngagementManager.h"

#pragma mark - Interface

@interface ProjectDetailsViewController () <ProjectCellDelegate, TextCellDelegate, ComposeSnippetViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;

@end

#pragma mark - Implementation

@implementation ProjectDetailsViewController

#pragma mark - Initializer

- (instancetype)initWithProject:(Project *)project
                    currentUser:(User *)currUser {
    self = [super init];
    if (self) {
        _project = project;
        _currUser = currUser;
    }
    return self;
}

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Project Details";
    [super setupBackButton];
    
    [self setupCollectionView];
    
    [self refreshData];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *const layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:layout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[RoundCell class]
        forCellWithReuseIdentifier:@"roundCell"];
    [_collectionView registerClass:[ProjectCell class]
        forCellWithReuseIdentifier:@"projectCell"];
    [_collectionView registerClass:[TextCell class]
        forCellWithReuseIdentifier:@"textCell"];
    
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    
    [self.view addSubview:_collectionView];
    
}

- (void)refreshData {
    __weak typeof (self) weakSelf = self;
    [ProjectUpdateManager updateProject:_project
                             completion:^(Project *project, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (error) {
            NSLog(@"Error, please try reloading page again: %@", error);
        } else {
            strongSelf.project = project;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf.collectionView reloadData];
            }
        });
    }];
}

#pragma mark - User actions

- (void)didTapPreview {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    if (latestRoundNumber >= 0) {
        Round *const currentRound = _project.rounds[latestRoundNumber];
        
        [NavigationManager presentSubmissionsViewControllerForRound:currentRound
                                                            project:_project
                                                            forUser:_currUser
                                               navigationController:self.navigationController];
    } else {
        NSLog(@"Nothing to preview.");
    }
}

#pragma mark - ProjectCellDelegate Protocol

- (void)didFollow:(Project *)project {
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    
    [_dao updateFollowersforProject:project withUserId:currUserId completion:^(NSError *error) {
        if (error) {
            NSLog(@"Error updating firebase with follow: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - TextCellDelegate Protocol

- (void)didTapCompose {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    if (latestRoundNumber >= 0) {
        Round *const currentRound = _project.rounds[latestRoundNumber];
        [NavigationManager presentComposeSnippetViewControllerForRound:currentRound
                                                             projectId:_project.projectId
                                                    fromViewController:self];
    } else {
        NSLog(@"Error, looks like project's rounds array was created without any Round objects in it.");
    }
}

#pragma mark - ComposeSnippetViewControllerDelegate Protocol

- (void)didSubmit:(Snippet *)snippet
            round:(Round *)round {
    ProjectBuilder *const projBuilder = [[[ProjectBuilder alloc] initWithProject:_project]
                                         updateLatestRound:round];
    
    if (projBuilder) {
        Project *const updatedProj = [projBuilder build];
        _project = updatedProj;
    } else {
        NSLog(@"Error adding submission to project.");
    }
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _project.rounds.count + 2;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        ProjectCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell"
                                                                            forIndexPath:indexPath];
        cell.project = _project;
        cell.delegate = self;
        return cell;
    } else if (indexPath.item == _project.rounds.count + 1) {
        TextCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"textCell"
                                                                         forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    } else {
        RoundCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"roundCell"
                                                                          forIndexPath:indexPath];
        
        Round *const round = _project.rounds[indexPath.item - 1];
        if (round.winningSnippetId) {
            [_dao getSubmissionWithId:round.winningSnippetId
                           forRoundId:round.roundId
                            projectId:_project.projectId
                           completion:^(Snippet *snippet, NSError *error) {
                snippet? [cell setSnippet:snippet] : [cell setSnippet:nil];
                
                __weak typeof(self) weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(self) strongSelf = weakSelf;
                    if (strongSelf) {
                        [cell setNeedsLayout];
                    }
                });
            }];
        } else {
            [cell setSnippet:nil];
        }
        
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate Protocol

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.item == _project.rounds.count) {
        Round *selectedRound = _project.rounds[indexPath.item - 1];
        
        [FIRAnalytics logEventWithName:kFIREventSelectContent
                            parameters:@{
                                kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", selectedRound.roundId],
                                kFIRParameterItemName:selectedRound.roundId,
                                kFIRParameterContentType:@"round"
                            }];
        
        [self didTapPreview];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 7.0);
}

@end
