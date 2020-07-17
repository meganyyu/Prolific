//
//  RoundBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Round;

#import "Entity.h"

#import "Round.h"
#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundBuilder : EntityBuilder

// required (and immutable) attributes
@property (nonatomic, strong) NSString *roundId;

// required (and mutable) attributes
@property (nonatomic) BOOL isComplete;
@property (nonatomic, strong) NSMutableArray<Snippet *> *submissions;

// optional (and immutable) attributes
@property (nonatomic, strong) NSString *winningSnippetId;

#pragma mark - Methods

- (RoundBuilder *)withId:(NSString *)roundId;

- (RoundBuilder *)isComplete:(BOOL)value;

- (RoundBuilder *)addSubmission:(Snippet *)snippet;

- (RoundBuilder *)withWinningSnippetId:(NSString *)winningSnippetId;

- (Round *)build;

@end

NS_ASSUME_NONNULL_END
