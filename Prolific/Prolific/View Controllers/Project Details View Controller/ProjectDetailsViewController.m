//
//  ProjectDetailsViewController.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectDetailsViewController.h"

#import "DAO.h"
#import "NavigationManager.h"
#import "ComposeSnippetViewController.h"
#import "ProjectCell.h"
#import "RoundCell.h"
#import "UIColor+ProlificColors.h"

static NSString *const kRoundComposeIconId = @"round-compose-icon";

#pragma mark - Interface

@interface ProjectDetailsViewController () <ComposeSnippetViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) UIView *projectView;
@property (nonatomic, strong) UIButton *composeButton;

@end

#pragma mark - Implementation

@implementation ProjectDetailsViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.navigationItem.title = @"Project Details";
    [super setupBackButton];
    
    [self setupCollectionView];
    // TODO: turn into collection view
    
    _projectView = [[UIView alloc] init];
    [self.view addSubview:_projectView];

    _composeButton = [[UIButton alloc] init];
    [_composeButton setImage:[UIImage imageNamed:kRoundComposeIconId] forState:normal];
    _composeButton.tintColor = [UIColor whiteColor];
    [_composeButton addTarget:self
                       action:@selector(onTapCompose:)
             forControlEvents:UIControlEventTouchUpInside];
    [_projectView addSubview:_composeButton];
    
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
    
    [_collectionView setBackgroundColor:[UIColor ProlificBackgroundGrayColor]];
    
    [self.view addSubview:_collectionView];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // project view
    _projectView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // compose button
    CGFloat const composeButtonWidth = 100;
    CGFloat const composeButtonHeight = 100;
    CGFloat const composeButtonX = _projectView.center.x - composeButtonWidth / 2.0;
    CGFloat const composeButtonY = boundsHeight - composeButtonHeight * 2.0;
    _composeButton.frame = CGRectMake(composeButtonX, composeButtonY, composeButtonWidth, composeButtonHeight);
}

- (void)refreshData {
    __weak typeof (self) weakSelf = self;
    [_dao getAllRoundsForProjectId:_project.projectId
                        completion:^(NSMutableArray * _Nonnull rounds, NSError * _Nonnull error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        if (rounds) {
            strongSelf.project.rounds = rounds;
            
            Round *const latestRound = strongSelf.project.rounds[strongSelf.project.rounds.count - 1];
            
            [strongSelf.dao getAllSubmissionsforRoundId:latestRound.roundId
                                    projectId:strongSelf.project.projectId
                                   completion:^(NSMutableArray * _Nonnull submissions, NSError * _Nonnull error) {
                __strong typeof (weakSelf) strongSelf = weakSelf;
                if (strongSelf == nil) return;
                
                if (submissions) {
                    RoundBuilder *const roundBuilder = [[[RoundBuilder alloc] initWithRound:latestRound]
                                                        withSubmissions:submissions];
                    RoundBuilder *const roundBuilderMarkedComplete = [roundBuilder markCompleteAndSetWinningSnippet];
                    RoundBuilder *const roundBuilderExtendedTime = [roundBuilder extendEndTime];
                    
                    if (roundBuilderMarkedComplete) {
                        Round *const updatedLatestRound = [roundBuilder build];
                        int latestRoundNumber = (int) strongSelf.project.rounds.count - 1;
                        strongSelf.project.rounds[latestRoundNumber] = updatedLatestRound;
                        
                        [strongSelf.dao updateExistingRound:updatedLatestRound
                                         forProjectId:strongSelf.project.projectId
                                           completion:^(NSError * _Nonnull error) {
                            if (error) {
                                NSLog(@"Error marking round as complete.");
                            }
                        }];
                        
                        RoundBuilder *const newRoundBuilder = [[RoundBuilder alloc] init];
                        [strongSelf.dao saveNewRoundWithBuilder:newRoundBuilder
                                             forProjectId:strongSelf.project.projectId
                                               completion:^(Round *round, NSError *error) {
                            __strong typeof (weakSelf) strongSelf = weakSelf;
                            if (strongSelf == nil) return;
                            
                            if (round) {
                                [strongSelf.project.rounds addObject:round];
                            } else {
                                NSLog(@"Failed to start a new round, try again.");
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                typeof(self) strongSelf = weakSelf;
                                if (strongSelf) {
                                    [strongSelf.collectionView reloadData];
                                }
                            });
                        }];
                    } else if (roundBuilderExtendedTime) {
                        Round *const extendedLatestRound = [roundBuilder build];
                        int latestRoundNumber = (int) strongSelf.project.rounds.count - 1;
                        strongSelf.project.rounds[latestRoundNumber] = extendedLatestRound;
                        
                        [strongSelf.dao updateExistingRound:extendedLatestRound
                                         forProjectId:strongSelf.project.projectId
                                           completion:^(NSError * _Nonnull error) {
                            if (error) {
                                NSLog(@"Error extending time for round.");
                            }
                        }];
                    }
                } else {
                    NSLog(@"Error retrieving submissions for latestRound: %@", error.localizedDescription);
                }
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf.collectionView reloadData];
                }
            });
        } else {
            NSLog(@"Failed to load rounds for project");
        }
    }];
}

#pragma mark - User actions

- (void)onTapCompose:(id)sender {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    if (latestRoundNumber >= 0) {
        Round *const currentRound = _project.rounds[latestRoundNumber];
        [NavigationManager presentComposeSnippetViewControllerForRound:currentRound
                                                             projectId:_project.projectId
                                                  navigationController:self.navigationController];
    } else {
        NSLog(@"Error, looks like project's rounds array was created without any Round objects in it.");
    }
}

- (void)didTapPreview {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    if (latestRoundNumber >= 0) {
        Round *const currentRound = _project.rounds[latestRoundNumber];
        [NavigationManager presentSubmissionsViewControllerForRound:currentRound
                                                          projectId:_project.projectId
                                               navigationController:self.navigationController];
    } else {
        NSLog(@"Nothing to preview.");
    }
}

#pragma mark - ComposeSnippetViewControllerDelegate Protocol

- (void)didSubmit:(Snippet *)snippet
            round:(Round *)round {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    latestRoundNumber >= 0 ? _project.rounds[latestRoundNumber] = round : NSLog(@"Error, project's rounds array has no Round objects in it.");
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _project.rounds.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        ProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell"
                                                                      forIndexPath:indexPath];
        cell.project = _project;
        
        return cell;
    } else {
        RoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"roundCell"
                                                                    forIndexPath:indexPath];
        
        Round *const round = _project.rounds[indexPath.item];
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
