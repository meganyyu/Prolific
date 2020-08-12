//
//  ProjectFeedCell.m
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectFeedCell.h"

#import "ProjectCell.h"
#import "UIColor+ProlificColors.h"

@implementation ProjectFeedCell

- (void)setupCollectionView {
    [super setupCollectionView];
    
    [self.collectionView registerClass:[ProjectCell class]
            forCellWithReuseIdentifier:@"projectCell"];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _projects.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProjectCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell"
                                                                        forIndexPath:indexPath];
    cell.project = _projects[indexPath.item];
    cell.cellView.followButton.hidden = YES;
    [cell setNeedsLayout];
    return cell;
}

@end
