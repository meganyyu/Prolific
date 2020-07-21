//
//  Snippet.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Snippet.h"

@import FirebaseFirestore;

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
    }
    return self;
}

@end
