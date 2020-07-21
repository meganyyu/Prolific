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

#pragma mark - Interface

@interface ProjectDetailsViewController () <ComposeSnippetViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) UIView *projectView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;
@property (nonatomic, strong) UIButton *composeButton;
@property (nonatomic, strong) UIButton *previewButton;

@end

#pragma mark - Implementation

@implementation ProjectDetailsViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dao = [[DAO alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Project Details";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onTapBack:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //[_collectionView registerClass:[SnippetCell class] forCellWithReuseIdentifier:@"snippetCell"];
    [_collectionView setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:_collectionView];
    
    // TODO: turn into collection view
    
    _projectView = [[UIView alloc] init];
    _projectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_projectView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.numberOfLines = 0;
    [_projectView addSubview:_nameLabel];
    
    _seedContentLabel = [[UILabel alloc] init];
    _seedContentLabel.textColor = [UIColor blackColor];
    _seedContentLabel.numberOfLines = 0;
    [_projectView addSubview:_seedContentLabel];
    
    _composeButton = [[UIButton alloc] init];
    _composeButton.backgroundColor = [UIColor lightGrayColor];
    [_composeButton setTitle:@"Submit a snippet!" forState:normal];
    [_composeButton addTarget:self action:@selector(onTapCompose:) forControlEvents:UIControlEventTouchUpInside];
    _composeButton.tintColor = [UIColor whiteColor];
    [_projectView addSubview:_composeButton];
    
    _previewButton = [[UIButton alloc] init];
    _previewButton.backgroundColor = [UIColor lightGrayColor];
    [_previewButton setTitle:@"See submitted snippets for latest round" forState:normal];
    [_previewButton addTarget:self action:@selector(onTapPreview:) forControlEvents:UIControlEventTouchUpInside];
    _previewButton.tintColor = [UIColor whiteColor];
    [_projectView addSubview:_previewButton];
    
    [self refreshData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect const bounds = self.view.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // project view
    _projectView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // project name label
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    CGFloat const nameLabelHeight = 0.2 * boundsHeight;
    CGFloat const nameLabelY = 0.05 * boundsHeight;
    _nameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    
    // seed content label
    CGFloat const seedContentLabelHeight = 0.6 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
    
    // compose button
    CGFloat const composeButtonX = _projectView.center.x - 150;
    CGFloat const composeButtonY = boundsHeight - 300;
    _composeButton.frame = CGRectMake(composeButtonX, composeButtonY, 300, 30);
    
    // preview button
    CGFloat const previewButtonX = _projectView.center.x - 200;
    CGFloat const previewButtonY = boundsHeight - 200;
    _previewButton.frame = CGRectMake(previewButtonX, previewButtonY, 400, 30);
}

- (void)refreshData {
    _nameLabel.text = _project.name;
    _seedContentLabel.text = _project.seed;
    
    [_dao getAllRoundsForProjectId:_project.projectId completion:^(NSMutableArray * _Nonnull rounds, NSError * _Nonnull error) {
        if (rounds) {
            self.project.rounds = rounds;
        } else {
            NSLog(@"Failed to load rounds for project");
        }
    }];
}

#pragma mark - User actions

- (void)onTapBack:(id)sender {
    [NavigationManager exitTopViewController:self.navigationController];
}

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

- (void)onTapPreview:(id)sender {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    if (latestRoundNumber >= 0) {
        Round *const currentRound = _project.rounds[latestRoundNumber];
        [NavigationManager presentSubmissionsViewControllerForRound:currentRound
                                                        projectId:_project.projectId
                                                    navigationController:self.navigationController];
    } else {
        NSLog(@"Error, looks like project's rounds array was created without any Round objects in it.");
    }
}

#pragma mark - ComposeSnippetViewControllerDelegate Protocol

- (void)didSubmit:(Snippet *)snippet round:(Round *)round {
    int latestRoundNumber = (int) _project.rounds.count - 1;
    latestRoundNumber >= 0 ? _project.rounds[latestRoundNumber] = round : NSLog(@"Error, looks like project's rounds array was created without any Round objects in it.");
}

#pragma mark - UICollectionViewDataSource Protocol

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

@end
