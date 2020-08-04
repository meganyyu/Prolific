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
        
        _badgeImageView = [[UIImageView alloc] init];
        _badgeImageView.backgroundColor = [UIColor ProlificPrimaryBlueColor];
        _badgeImageView.layer.cornerRadius = 5.0;
        [self addSubview:_badgeImageView];
        
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
    CGFloat const badgeHeight = badgeWidth;
    CGFloat const badgeX = 0.05 * boundsWidth;
    CGFloat const badgeY = boundsHeight / 2.0 - badgeHeight / 2.0;
    _badgeImageView.frame = CGRectMake(badgeX, badgeY, badgeWidth, badgeHeight);
    
    CGFloat const progressBarWidth = 0.6 * boundsWidth;
    CGFloat const progressBarHeight = 10;
    CGFloat const progressBarX = badgeX + badgeWidth + 30;
    CGFloat const progressBarY = boundsHeight / 2.0 - progressBarHeight / 2.0;
    _progressBar.frame = CGRectMake(progressBarX, progressBarY, progressBarWidth, progressBarHeight);
}

@end
