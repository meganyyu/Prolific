//
//  Snippet.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Snippet.h"

@import FirebaseFirestore;
@import FirebaseAuth;

@implementation Snippet

#pragma mark - Initializer

- (instancetype)initWithBuilder:(SnippetBuilder *)builder {
    self = [super init];
    if (self) {
        _snippetId = builder.snippetId;
        _authorId = builder.authorId;
        _text = builder.text;
        _createdAt = builder.createdAt;
        _voteCount = builder.voteCount;
        _userVoted = builder.userVoted;
        _userVotes = builder.userVotes;
        _rank = builder.rank;
        _score = builder.score;
    }
    return self;
}

@end
