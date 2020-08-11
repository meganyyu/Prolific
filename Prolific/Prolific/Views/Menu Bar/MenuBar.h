//
//  MenuBar.h
//  Prolific
//
//  Created by meganyu on 8/10/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProfileViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuBar : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)moveHorizontalBarToX:(CGFloat)x;

@end

@interface MenuCell : UICollectionViewCell

@property (nonatomic, strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
