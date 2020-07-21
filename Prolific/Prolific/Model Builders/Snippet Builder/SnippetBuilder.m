//
//  SnippetBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetBuilder.h"

@import Firebase;

static NSString *const kAuthorIdKey = @"authorId";
static NSString *const kCreatedAtKey = @"createdAt";
static NSString *const kTextKey = @"text";
static NSString *const kVoteCountKey = @"voteCount";
static NSString *const kUserVotesKey = @"userVotes";

@implementation SnippetBuilder

- (id)init {
    self = [super init];
    if (self) {
        _snippetId = nil;
        _authorId = [FIRAuth auth].currentUser.uid;
        _createdAt = [FIRTimestamp timestamp].dateValue;
        _text = nil;
        _voteCount = [NSNumber numberWithInt:0];
        _userVoted = NO;
    }
    return self;
}

- (instancetype)initWithId:(NSString *)snippetId dictionary:(NSDictionary *)data {
    self = [self init];
    
    if (self) {
        if (snippetId &&
            [data objectForKey:kAuthorIdKey] &&
            [data objectForKey:kCreatedAtKey] &&
            [data objectForKey:kTextKey] &&
            [data objectForKey:kVoteCountKey] &&
            [data objectForKey:kUserVotesKey]) {
            _snippetId = snippetId;
            _authorId = data[kAuthorIdKey];
            _createdAt = data[kCreatedAtKey];
            _text = data[kTextKey];
            _voteCount = data[kVoteCountKey];
            
            NSString *const currUserId = [FIRAuth auth].currentUser.uid;
            _userVoted = [data[kUserVotesKey] containsObject:currUserId];
        }
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

- (SnippetBuilder *)withCreatedAt:(NSDate *)date {
    _createdAt = date;
    return self;
}

- (SnippetBuilder *)withVoteCount:(NSNumber *)voteCount {
    _voteCount = voteCount;
    return self;
}

- (Snippet *)build {
    if (_snippetId && _authorId && _text && _createdAt && _voteCount) {
        Snippet *snippet = [[Snippet alloc] initWithBuilder:self];
        return snippet;
    }
    return nil;
}

@end
