//
//  RoundCellView.m
//  Prolific
//
//  Created by meganyu on 7/23/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundCellView.h"

static NSString *const kForwardArrowIconId = @"forward-arrow-icon";
static NSString *const kFinishedVoteIconID = @"finished-vote-icon";

@implementation RoundCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _roundCountLabel = [[CountLabel alloc] init];
        [self addSubview:_roundCountLabel];
        
        _openButton = [[UIButton alloc] init];
        [self addSubview:_openButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    
    // round count label
    CGFloat const roundCountLabelWidth = _roundCountLabel.bounds.size.width;
    CGFloat const roundCountLabelHeight = _roundCountLabel.bounds.size.height;
    CGFloat const roundCountLabelX = labelX;
    CGFloat const roundCountLabelY = boundsHeight - roundCountLabelHeight;
    _roundCountLabel.frame = CGRectMake(roundCountLabelX, roundCountLabelY, roundCountLabelWidth, roundCountLabelHeight);
    
    // open round button
    CGFloat const openButtonWidth = 20;
    CGFloat const openButtonHeight = 20;
    CGFloat const openButtonX = labelWidth + 5;
    CGFloat const openButtonY = boundsHeight / 2.0;
    _openButton.frame = CGRectMake(openButtonX, openButtonY, openButtonWidth, openButtonHeight);
    [_openButton setImage:[UIImage imageNamed:kForwardArrowIconId] forState:normal];
    
    [self.voteButton setImage:[UIImage imageNamed:kFinishedVoteIconID] forState:normal];
}

@end
