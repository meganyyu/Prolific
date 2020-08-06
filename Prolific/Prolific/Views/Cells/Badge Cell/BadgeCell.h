//
//  BadgeCellView.h
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BadgeCell : UICollectionViewCell

@property (nonatomic, strong) UIView *badgeBackdropView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UIView *progressBar;

@end

NS_ASSUME_NONNULL_END
