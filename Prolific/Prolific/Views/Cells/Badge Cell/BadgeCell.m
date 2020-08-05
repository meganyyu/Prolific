//
//  BadgeCellView.m
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BadgeCell.h"
#import "UIColor+ProlificColors.h"

@implementation BadgeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _badgeBackdropView = [[UIView alloc] init];
        _badgeBackdropView.backgroundColor = [UIColor ProlificPrimaryBlueColor];
        _badgeBackdropView.layer.cornerRadius = 5.0;
        [self addSubview:_badgeBackdropView];
        
        _badgeImageView = [[UIImageView alloc] init];
        _badgeImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_badgeImageView];
        
        _badgeLevelLabel = [[UILabel alloc] init];
        _badgeLevelLabel.textColor = [UIColor whiteColor];
        _badgeLevelLabel.font = [UIFont systemFontOfSize:14];
        _badgeLevelLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_badgeLevelLabel];
        
        _progressBar = [[UIView alloc] init];
        _progressBar.backgroundColor = [UIColor ProlificGray2Color];
        _progressBar.layer.cornerRadius = 5.0;
        [self addSubview:_progressBar];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    
    CGFloat const badgeWidth = 0.2 * boundsWidth;
    CGFloat const badgeHeight = 0.6 * boundsHeight;
    CGFloat const badgeX = 0.05 * boundsWidth;
    CGFloat const badgeY = boundsHeight / 2.0 - badgeHeight / 2.0;
    _badgeBackdropView.frame = CGRectMake(badgeX, badgeY, badgeWidth, badgeHeight);
    
    CGFloat const badgeImageWidth = 0.7 * badgeWidth;
    CGFloat const badgeImageHeight = badgeImageWidth;
    CGFloat const badgeImageX = _badgeBackdropView.center.x - badgeImageWidth / 2.0;
    CGFloat const badgeImageY = badgeY + 0.1 * badgeHeight;
    _badgeImageView.frame = CGRectMake(badgeImageX, badgeImageY, badgeImageWidth, badgeImageHeight);
    
    CGFloat const levelLabelWidth = badgeImageWidth;
    CGFloat const levelLabelHeight = 0.2 * badgeHeight;
    CGFloat const levellabelX = _badgeBackdropView.center.x - levelLabelWidth / 2.0;
    CGFloat const levelLabelY = badgeImageY + badgeImageHeight + 0.05 * badgeHeight;
    _badgeLevelLabel.frame = CGRectMake(levellabelX, levelLabelY, levelLabelWidth, levelLabelHeight);
    _badgeLevelLabel.text = @"Level 1";
    
    CGFloat const progressBarWidth = 0.6 * boundsWidth;
    CGFloat const progressBarHeight = 10;
    CGFloat const progressBarX = badgeX + badgeWidth + 30;
    CGFloat const progressBarY = boundsHeight / 2.0 - progressBarHeight / 2.0;
    _progressBar.frame = CGRectMake(progressBarX, progressBarY, progressBarWidth, progressBarHeight);
}

@end
