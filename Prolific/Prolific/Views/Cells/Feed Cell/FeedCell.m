//
//  FeedCell.m
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FeedCell.h"

#import "UIColor+ProlificColors.h"

@interface FeedCell ()

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation FeedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame
                                         collectionViewLayout:_layout];
    
    [_collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cellId"];
    
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.contentView.bounds;
}

@end
