//
//  SnippetBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetBuilder.h"

@implementation SnippetBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _snippetId = @"testSnippetId";
        _authorId = @"testAuthorId";
        _createdAtDate = [NSDate date];
        _text = @"";
    }
    return self;
}

- (SnippetBuilder *)withId:(NSString *)snippetId {
    _snippetId = snippetId;
    return self;
}

- (SnippetBuilder *)withAuthor:(NSString *)authorId {
    _authorId = authorId;
    return self;
}

- (SnippetBuilder *)withText:(NSString *)text {
    _text = text;
    return self;
}

- (SnippetBuilder *)withVoteCount:(NSNumber *)voteCount {
    _voteCount = voteCount;
    return self;
}

- (Snippet *)build {
    Snippet *snippet = [[Snippet alloc] initWithBuilder:self];
    return snippet;
}
@end
