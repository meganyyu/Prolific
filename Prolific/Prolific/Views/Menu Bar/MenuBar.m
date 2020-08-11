//
//  MenuBar.m
//  Prolific
//
//  Created by meganyu on 8/10/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "MenuBar.h"

#import "UIColor+ProlificColors.h"

@interface MenuBar () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation MenuBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:_layout];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[MenuCell class]
        forCellWithReuseIdentifier:@"menuCell"];
    
    NSIndexPath *const selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [_collectionView selectItemAtIndexPath:selectedIndexPath
                                  animated:NO
                            scrollPosition:UICollectionViewScrollPositionNone];
    
    [self addSubview:_collectionView];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    
    _collectionView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell"
                                                                                 forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width / 2, self.frame.size.height);
    
}

@end

@implementation MenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
