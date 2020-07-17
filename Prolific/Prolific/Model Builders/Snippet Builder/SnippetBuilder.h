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
@property (nonatomic, strong) NSDate *createdAtDate;

// required (and mutable) attributes
@property (nonatomic, strong) NSNumber *voteCount;

#pragma mark - Methods

/** Returns SnippetBuilder with all fields initialized based on dictionary data, unless data is missing values, in which case it initializes a SnippetBuilder the same way as init does. */
- (instancetype)initWithId:(NSString *)snippetId dictionary:(NSDictionary *)data;

- (SnippetBuilder *)withId:(NSString *)snippetId;

- (SnippetBuilder *)withAuthor:(NSString *)authorId;

- (SnippetBuilder *)withText:(NSString *)text;

- (SnippetBuilder *)withVoteCount:(NSNumber *)voteCount;

/** Returns fully built Snippet if SnippetBuilder has all fields initialized properly. Else returns nil. */
- (Snippet *)build;

@end

NS_ASSUME_NONNULL_END
