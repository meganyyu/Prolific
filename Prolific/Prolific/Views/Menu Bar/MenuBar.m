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
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) UIView *horizontalBarView;

@end

@implementation MenuBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuTitles = @[@"Badges", @"Projects"];
        
        [self setupCollectionView];
        [self setupHorizontalBar];
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

- (void)setupHorizontalBar {
    _horizontalBarView = [[UIView alloc] init];
    _horizontalBarView.backgroundColor = [UIColor ProlificGoldColor];
    [self addSubview:_horizontalBarView];
    
    CGFloat barWidth = self.bounds.size.width / 2;
    CGFloat barHeight = 5;
    CGFloat barY = self.bounds.size.height - barHeight;
    _horizontalBarView.frame = CGRectMake(0, barY, barWidth, barHeight);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    
    _collectionView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
}

#pragma mark - Horizontal bar controls

- (void)moveHorizontalBarToX:(CGFloat)x {
    CGRect frame = self.horizontalBarView.frame;
    frame.origin.x = x;
    self.horizontalBarView.frame = frame;
}

#pragma mark - UICollectionViewDataSource Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *const cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell"
                                                                     forIndexPath:indexPath];
    cell.title = _menuTitles[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_viewController scrollToMenuIndex:indexPath.item];
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

@interface MenuCell ()

@property (nonatomic, strong) UILabel *menuLabel;

@end

@implementation MenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupViews {
    _menuLabel = [[UILabel alloc] initWithFrame:self.frame];
    _menuLabel.textAlignment = NSTextAlignmentCenter;
    _menuLabel.textColor = [UIColor ProlificGray2Color];
    [self addSubview:_menuLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _menuLabel.frame = self.contentView.bounds;
    _menuLabel.text = _title;
}

- (void)setHighlighted:(BOOL)highlighted {
    _menuLabel.textColor = highlighted ? [UIColor blackColor] : [UIColor ProlificGray2Color];
}

- (void)setSelected:(BOOL)selected {
    _menuLabel.textColor = selected ? [UIColor blackColor] : [UIColor ProlificGray2Color];
}

@end
