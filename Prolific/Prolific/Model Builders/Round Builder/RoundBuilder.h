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

/** Returns RoundBuilder with all fields initialized based on dictionary data, unless data is missing values, in which case it initializes a RoundBuilder the same way as init does. */
- (instancetype)initWithId:(NSString *)roundId dictionary:(NSDictionary *)data submissions:(NSMutableArray *)submissions;

- (RoundBuilder *)withId:(NSString *)roundId;

- (RoundBuilder *)isComplete:(BOOL)value;

- (RoundBuilder *)withSubmissions:(NSMutableArray<Snippet *> *)submissions;

- (RoundBuilder *)withWinningSnippetId:(NSString *)winningSnippetId;

/** Returns fully built Round if RoundBuilder has all fields initialized properly. Else returns nil. */
- (Round *)build;

@end

NS_ASSUME_NONNULL_END
