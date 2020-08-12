//
//  ProjectCellView.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectCellView.h"

static NSString *const kInProgressIconID = @"in-progress-icon";
static NSString *const kDoneIconID = @"done-icon";

@implementation ProjectCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:_nameLabel];
        
        _statusIcon = [[UIImageView alloc] init];
        [self addSubview:_statusIcon];
        
        _seedContentLabel = [[UILabel alloc] init];
        [_seedContentLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_seedContentLabel];
        
        _followButton = [[FollowButton alloc] init];
        [self addSubview:_followButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    
    // project name label
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.numberOfLines = 0;
    CGFloat const nameLabelHeight = 0.15 * boundsHeight;
    CGFloat const nameLabelY = 0.15 * boundsHeight;
    _nameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    
    // seed content label
    _seedContentLabel.textColor = [UIColor blackColor];
    _seedContentLabel.numberOfLines = 0;
    CGFloat const seedContentLabelHeight = 0.6 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
    
    // status icon
    CGFloat const statusIconWidth = 75;
    CGFloat const statusIconHeight = 20;
    CGFloat const statusIconX = labelX;
    CGFloat const statusIconY = boundsHeight - statusIconHeight - labelX;
    _statusIcon.frame = CGRectMake(statusIconX, statusIconY, statusIconWidth, statusIconHeight);
    [_statusIcon setImage:[[UIImage imageNamed:kInProgressIconID] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // follow count label
    CGFloat const followCountLabelWidth = _followCountLabel.bounds.size.width;
    CGFloat const followCountLabelHeight = _followCountLabel.bounds.size.height;
    CGFloat const followCountLabelX = labelWidth - followCountLabelWidth;
    CGFloat const followCountLabelY = boundsHeight - followCountLabelHeight - 0.05 * boundsHeight;
    _followCountLabel.frame = CGRectMake(followCountLabelX, followCountLabelY, followCountLabelWidth, followCountLabelHeight);
    
    // follow button
    CGFloat const followButtonHeight = _followButton.bounds.size.height;
    CGFloat const followButtonWidth = _followButton.bounds.size.width;
    CGFloat const followButtonX = followCountLabelX - followButtonWidth - 5;
    CGFloat const followButtonY = boundsHeight - followButtonHeight - 0.05 * boundsHeight;
    _followButton.frame = CGRectMake(followButtonX, followButtonY, followButtonWidth, followButtonHeight);
}

@end
