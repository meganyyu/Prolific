//
//  SnippetCellView.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetCellView.h"

@implementation SnippetCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _usernameLabel = [[UILabel alloc] init];
        [self addSubview:_usernameLabel];
        
        _seedContentLabel = [[UILabel alloc] init];
        [self addSubview:_seedContentLabel];
        
        _voteButton = [[VoteButton alloc] init];
        [self addSubview:_voteButton];
        
        _voteCountLabel = [[CountLabel alloc] init];
        [self addSubview:_voteCountLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    
    // username label
    _usernameLabel.textColor = [UIColor blackColor];
    _usernameLabel.numberOfLines = 1;
    CGFloat const nameLabelHeight = 0.2 * boundsHeight;
    CGFloat const nameLabelY = 0.05 * boundsHeight;
    _usernameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    
    // seed content label
    _seedContentLabel.textColor = [UIColor blackColor];
    _seedContentLabel.numberOfLines = 0;
    CGFloat const seedContentLabelHeight = 0.5 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
    
    // vote count label
    CGFloat const voteCountLabelWidth = _voteCountLabel.bounds.size.width;
    CGFloat const voteCountLabelHeight = _voteCountLabel.bounds.size.height;
    CGFloat const voteCountLabelX = boundsWidth - voteCountLabelWidth;
    CGFloat const voteCountLabelY = boundsHeight - voteCountLabelHeight;
    _voteCountLabel.frame = CGRectMake(voteCountLabelX, voteCountLabelY, voteCountLabelWidth, voteCountLabelHeight);
    
    // vote button
    CGFloat const voteButtonWidth = _voteButton.bounds.size.width;
    CGFloat const voteButtonHeight = _voteButton.bounds.size
    .height;
    CGFloat const voteButtonX = voteCountLabelX - voteButtonWidth - 5;
    CGFloat const voteButtonY = voteCountLabelY + 5;
    _voteButton.frame = CGRectMake(voteButtonX, voteButtonY, voteButtonWidth, voteButtonHeight);
}

@end
