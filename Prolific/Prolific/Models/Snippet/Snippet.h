//
//  Snippet.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class SnippetBuilder;

#import "Entity.h"

#import "SnippetBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Snippet : Entity

// required (and immutable) attributes
@property (nonatomic, strong, readonly) NSString *snippetId;
@property (nonatomic, strong, readonly) NSString *authorId;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSDate *createdAt;

// required (and mutable) attributes
@property (nonatomic, strong, readonly) NSNumber *voteCount;

#pragma mark - Methods

- (instancetype)initWithBuilder:(SnippetBuilder *)builder;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
