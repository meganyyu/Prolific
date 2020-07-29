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
        _createdAt = [ProlificUtils convertTimestampToDate:[FIRTimestamp timestamp]];
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
            [self validateRequiredDictionaryData:data]) {
            _snippetId = snippetId;
            _authorId = data[kAuthorIdKey];
            _createdAt = [ProlificUtils convertTimestampToDate:data[kCreatedAtKey]];
            _text = data[kTextKey];
            _voteCount = data[kVoteCountKey];
            
            if ([[data objectForKey:kUserVotesKey] isKindOfClass:[NSArray class]]) {
                NSString *const currUserId = [FIRAuth auth].currentUser.uid;
                _userVoted = [data[kUserVotesKey] containsObject:currUserId];
            }
        }
    }
    return self;
}

- (instancetype)initWithSnippet:(Snippet *)snippet {
    self = [self init];
    
    if (self) {
        _snippetId = snippet.snippetId;
        _authorId = snippet.authorId;
        _createdAt = snippet.createdAt;
        _text = snippet.text;
        _voteCount = snippet.voteCount;
        _userVoted = snippet.userVoted;
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

#pragma mark - Helper functions

/** Validates that the data passed in through a dictionary is valid. */
- (BOOL)validateRequiredDictionaryData:(NSDictionary *)data {
    return [[data objectForKey:kAuthorIdKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kCreatedAtKey] isKindOfClass:[FIRTimestamp class]] &&
    [[data objectForKey:kTextKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kVoteCountKey] isKindOfClass:[NSNumber class]];
}

@end
