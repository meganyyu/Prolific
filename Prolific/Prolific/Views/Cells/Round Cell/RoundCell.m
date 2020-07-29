//
//  RoundCell.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundCell.h"

@implementation RoundCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellView = [[RoundCellView alloc] initWithFrame:frame];
        [self.contentView addSubview:_cellView];
        _cellView.snippet = _snippet;
    }
    return self;
}

#pragma mark - Setup

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cellView.frame = self.contentView.bounds;
    
    if (_snippet) {
        _cellView.showSnippet = YES;
        _cellView.snippet = _snippet;
        [_cellView setNeedsLayout];
    } else {
        _cellView.showSnippet = NO;
        [_cellView setNeedsLayout];
    }
}

- (void)setSnippet:(Snippet *)snippet {
    _snippet = snippet;
}

@end
