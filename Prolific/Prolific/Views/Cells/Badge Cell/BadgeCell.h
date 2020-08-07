//
//  BadgeCellView.h
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Badge.h"
#import "HorizontalProgressBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BadgeCell : UICollectionViewCell

@property (nonatomic, strong) Badge *badge;
@property (nonatomic, strong) UIView *badgeBackdropView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) HorizontalProgressBar *progressBar;

@end

NS_ASSUME_NONNULL_END
