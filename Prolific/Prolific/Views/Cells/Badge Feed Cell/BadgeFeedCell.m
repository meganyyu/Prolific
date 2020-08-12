//
//  BadgeFeedCell.m
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BadgeFeedCell.h"

#import "BadgeCell.h"

@implementation BadgeFeedCell

- (void)setupCollectionView {
    [super setupCollectionView];
    
    [self.collectionView registerClass:[BadgeCell class]
            forCellWithReuseIdentifier:@"badgeCell"];
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _badges.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell"
                                                                      forIndexPath:indexPath];
    cell.badge = _badges[indexPath.item];
    return cell;
}

@end
