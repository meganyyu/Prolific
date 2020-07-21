//
//  SnippetCell.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetCell.h"

@implementation SnippetCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cellView = [[SnippetCellView alloc] init];
    [self addSubview:_cellView];
    
    CGRect const bounds = self.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    [_cellView drawRect:CGRectMake(0, 0, boundsWidth, boundsHeight)];
    
    _cellView.usernameLabel.text = _snippet.authorId;
    _cellView.seedContentLabel.text = _snippet.text;
    _cellView.voteCountLabel.text = [_snippet.voteCount stringValue];
}

@end
