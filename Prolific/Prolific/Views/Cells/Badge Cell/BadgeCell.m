//
//  BadgeCellView.m
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BadgeCell.h"
#import "UIColor+ProlificColors.h"

#pragma mark - Badge Types

static NSString *const kContributorBadgeId = @"contributor-badge";
static NSString *const kBigHitWriterBadgeId = @"big-hit-writer-badge";
static NSString *const kCreatorBadgeId = @"creator-badge";

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
        [self addSubview:_badgeImageView];
        
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.textColor = [UIColor whiteColor];
        _levelLabel.font = [UIFont systemFontOfSize:14];
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_levelLabel];
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = [UIColor blackColor];
        _typeLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_typeLabel];
        
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_progressLabel];
        
        _progressBar = [[HorizontalProgressBar alloc] init];
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
    _levelLabel.frame = CGRectMake(levellabelX, levelLabelY, levelLabelWidth, levelLabelHeight);
    
    CGFloat const progressBarWidth = 0.6 * boundsWidth;
    CGFloat const progressBarHeight = 15;
    CGFloat const progressBarX = badgeX + badgeWidth + 30;
    CGFloat const progressBarY = badgeY + badgeHeight - progressBarHeight;
    _progressBar.frame = CGRectMake(progressBarX, progressBarY, progressBarWidth, progressBarHeight);
    
    CGFloat const typeLabelWidth = progressBarWidth;
    CGFloat const typeLabelHeight = 0.3 * badgeHeight;
    CGFloat const typeLabelX = progressBarX;
    CGFloat const typeLabelY = badgeImageY;
    _typeLabel.frame = CGRectMake(typeLabelX, typeLabelY, typeLabelWidth, typeLabelHeight);

    CGFloat const progressLabelWidth = progressBarWidth;
    CGFloat const progressLabelHeight = 0.2 * badgeHeight;
    CGFloat const progressLabelX = typeLabelX;
    CGFloat const progressLabelY = typeLabelY + typeLabelHeight + 0.05 * boundsHeight;
    _progressLabel.frame = CGRectMake(progressLabelX, progressLabelY, progressLabelWidth, progressLabelHeight);
    
    [self loadBadgeData];
}

- (void)loadBadgeData {
    [_badgeImageView setImage:[UIImage imageNamed:_badge.badgeType]];
    
    _levelLabel.text = [NSString stringWithFormat:@"Level %@", _badge.level];
    _typeLabel.text = _badge.badgeName;
    
    NSInteger goalRemaining = [_badge.totalGoal intValue] - [_badge.goalCompletedSoFar intValue];
    _progressLabel.text = [NSString stringWithFormat:@"%@ %ld more %@!", _badge.actionType, goalRemaining, _badge.metricType];
    
    CGFloat progress = [_badge.goalCompletedSoFar floatValue] / [_badge.totalGoal floatValue];
    [_progressBar setProgress:progress];
}

@end
