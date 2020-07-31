//
//  SnippetCell.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetCell.h"

#import "SnippetBuilder.h"

static NSString *const kTappedVoteIconID = @"tapped-vote-icon";
static NSString *const kUntappedVoteIconID = @"untapped-vote-icon";

#pragma mark - Implementation

@implementation SnippetCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellView = [[SnippetCellView alloc] initWithFrame:frame];
        [self.contentView addSubview:_cellView];
    }
    return self;
}

#pragma mark - Setup

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cellView.frame = self.contentView.bounds;
    
    _cellView.usernameLabel.text = _snippet.authorId;
    _cellView.seedContentLabel.text = _snippet.text;
    _cellView.voteCountLabel.text = [_snippet.voteCount stringValue];
    
    [_cellView.voteButton addTarget:self
                             action:@selector(onTapVote:)
                   forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - User actions

- (void)onTapVote:(id)sender {
    Snippet *const updatedSnippet = [[[[SnippetBuilder alloc] initWithSnippet:_snippet]
                                      updateCurrentUserVote]
                                     build];
    if (updatedSnippet) {
        _snippet = updatedSnippet;
    } else {
        return;
    }
    
    [_delegate didVote:_snippet];
    
    UIImage *const voteIcon = [UIImage imageNamed:(_snippet.userVoted ? kTappedVoteIconID : kUntappedVoteIconID)];
    [_cellView.voteButton setImage:voteIcon
                          forState:UIControlStateNormal];
    _cellView.voteCountLabel.text = [_snippet.voteCount stringValue];
}

@end
