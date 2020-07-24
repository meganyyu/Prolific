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
    }
    return self;
}

#pragma mark - Setup

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cellView.frame = self.contentView.bounds;
    
    if (_snippet) {
        _cellView.usernameLabel.hidden = NO;
        _cellView.voteCountLabel.hidden = NO;
        _cellView.voteButton.hidden = NO;
        
        _cellView.usernameLabel.text = _snippet.authorId;
        _cellView.seedContentLabel.text = _snippet.text;
        _cellView.voteCountLabel.text = [_snippet.voteCount stringValue];
    } else {
        _cellView.usernameLabel.hidden = YES;
        _cellView.voteCountLabel.hidden = YES;
        _cellView.voteButton.hidden = YES;
        
        _cellView.seedContentLabel.text = @"Voting in progress!";
    }
}

- (void)setSnippet:(Snippet *)snippet {
    _snippet = snippet;
}

@end
