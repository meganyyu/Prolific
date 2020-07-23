//
//  Round.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class RoundBuilder;

#import "Entity.h"

#import "Snippet.h"
#import "RoundBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Round : Entity

// required (and immutable) attributes
@property (nonatomic, strong, readonly) NSString *roundId;
@property (nonatomic, strong, readonly) NSDate *createdAt;

// required (and mutable) attributes
@property (nonatomic, readonly) BOOL isComplete;
@property (nonatomic, strong, readonly) NSDate *endTime;
@property (nonatomic, strong) NSMutableArray<Snippet *> *submissions;

// optional (and immutable) attributes
@property (nonatomic, strong, readonly) NSString *winningSnippetId;

#pragma mark - Methods

- (instancetype)initWithBuilder:(RoundBuilder *)builder;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

/** Only returns true if round contains at least one submission, hasn't already been marked as complete, and current time is past specified round end time. */
- (BOOL)needToMarkAsComplete;

/** Only returns true if round contains no submissions, hasn't been marked as complete, and current time is past specified round end time. */
- (BOOL)needToExtendTime;

/** Only extends the end time by 1 day if there are no submissions in the round. */
- (BOOL)extendEndTime;

/** Only marks a round as complete and sets a winning snippet Id if the round is ready and hasn't already been marked as complete. */
- (BOOL)markCompleteAndSetWinningSnippet;

@end

NS_ASSUME_NONNULL_END
