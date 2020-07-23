//
//  SnippetCell.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetCell.h"

#import "DAO.h"

#pragma mark - Implementation

static NSString *const kTappedVoteIconID = @"tapped-vote-icon";
static NSString *const kUntappedVoteIconID = @"untapped-vote-icon";

@implementation SnippetCell

#pragma mark - Setup

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect const bounds = self.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGRect const cellFrame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    _cellView = [[SnippetCellView alloc] initWithFrame:cellFrame];
    [self addSubview:_cellView];
    
    _cellView.usernameLabel.text = _snippet.authorId;
    _cellView.seedContentLabel.text = _snippet.text;
    _cellView.voteCountLabel.text = [_snippet.voteCount stringValue];
    
    [_cellView.voteButton addTarget:self
                             action:@selector(onTapVote:)
                   forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - User actions

- (void)onTapVote:(id)sender {
    [_snippet updateCurrentUserVote];
    [self.delegate didVote:_snippet];
    
    UIImage *const voteIcon = [UIImage imageNamed:(_snippet.userVoted ? kTappedVoteIconID : kUntappedVoteIconID)];
    [_cellView.voteButton setImage:voteIcon
                          forState:UIControlStateNormal];
    _cellView.voteCountLabel.text = [_snippet.voteCount stringValue];
}

@end
