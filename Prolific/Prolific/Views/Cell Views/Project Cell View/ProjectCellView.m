//
//  ProjectCellView.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectCellView.h"

@implementation ProjectCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        
        _seedContentLabel = [[UILabel alloc] init];
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
    CGFloat const nameLabelHeight = 0.2 * boundsHeight;
    CGFloat const nameLabelY = 0.05 * boundsHeight;
    _nameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    
    // seed content label
    _seedContentLabel.textColor = [UIColor blackColor];
    _seedContentLabel.numberOfLines = 0;
    CGFloat const seedContentLabelHeight = 0.6 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
    
    // follow count label
    CGFloat const followCountLabelWidth = _followCountLabel.bounds.size.width;
    CGFloat const followCountLabelHeight = _followCountLabel.bounds.size.height;
    CGFloat const followCountLabelX = labelWidth - followCountLabelWidth;
    CGFloat const followCountLabelY = boundsHeight - followCountLabelHeight - 0.05 * boundsHeight;;
    _followCountLabel.frame = CGRectMake(followCountLabelX, followCountLabelY, followCountLabelWidth, followCountLabelHeight);
    
    // follow button
    CGFloat const followButtonHeight = _followButton.bounds.size.height;
    CGFloat const followButtonWidth = _followButton.bounds.size.width;
    CGFloat const followButtonX = followCountLabelX - followButtonWidth - 5;
    CGFloat const followButtonY = boundsHeight - followButtonHeight - 0.05 * boundsHeight;
    _followButton.frame = CGRectMake(followButtonX, followButtonY, followButtonWidth, followButtonHeight);
}

@end
