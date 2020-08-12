//
//  FeedCell.m
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FeedCell.h"

#import "UIColor+ProlificColors.h"

@interface FeedCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

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
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
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

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId"
                                                                        forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width - 50, collectionView.frame.size.height / 3.0);
}


@end
