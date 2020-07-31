//
//  SnippetBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Snippet;

#import "Entity.h"

#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@interface SnippetBuilder : EntityBuilder

#pragma mark - Methods

// required (and immutable) attributes
@property (nonatomic, strong) NSString *snippetId;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;

// required (and mutable) attributes
@property (nonatomic, strong) NSNumber *voteCount;
@property (nonatomic) BOOL userVoted;

// optional (and mutable) attributes
@property (nonatomic, strong) NSMutableArray *userVotes;
@property (nonatomic, strong) NSNumber *rank;
@property (nonatomic, strong) NSDecimalNumber *score;

#pragma mark - Methods

/** Returns SnippetBuilder with all fields initialized based on dictionary data, unless data is missing values, in which case it initializes a SnippetBuilder the same way as init does. */
- (instancetype)initWithId:(NSString *)snippetId dictionary:(NSDictionary *)data;

/** Returns SnippetBuilder with all fields initialized as a copy of a Snippet model. */
- (instancetype)initWithSnippet:(Snippet *)snippet;

- (SnippetBuilder *)withId:(NSString *)snippetId;

- (SnippetBuilder *)withAuthor:(NSString *)authorId;

- (SnippetBuilder *)withText:(NSString *)text;

- (SnippetBuilder *)withCreatedAt:(NSDate *)date;

- (SnippetBuilder *)withVoteCount:(NSNumber *)voteCount;

- (SnippetBuilder *)updateCurrentUserVote;

- (SnippetBuilder *)withRank:(NSNumber *)rank;

- (SnippetBuilder *)withScore:(NSDecimalNumber *)score;

/** Returns fully built Snippet if SnippetBuilder has all fields initialized properly. Else returns nil. */
- (Snippet *)build;

@end

NS_ASSUME_NONNULL_END
