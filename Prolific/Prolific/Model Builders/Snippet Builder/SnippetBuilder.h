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

- (SnippetBuilder *)withId:(NSString *)snippetId;

- (SnippetBuilder *)withAuthor:(NSString *)authorId;

- (SnippetBuilder *)withText:(NSString *)text;

- (SnippetBuilder *)withVoteCount:(NSNumber *)voteCount;

- (Snippet *)build;

@end

NS_ASSUME_NONNULL_END
