//
//  FeedCell.h
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedCell : UICollectionViewCell

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setupCollectionView;

@end

NS_ASSUME_NONNULL_END
