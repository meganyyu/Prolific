//
//  RoundBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Round;

#import "Entity.h"

@import Firebase;
#import "Round.h"
#import "Snippet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundBuilder : EntityBuilder

// required (and immutable) attributes
@property (nonatomic, strong) NSString *roundId;
@property (nonatomic, strong) NSDate *createdAt;

// required (and mutable) attributes
@property (nonatomic) BOOL isComplete;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) NSMutableArray<Snippet *> *submissions;

// optional (and immutable) attributes
@property (nonatomic, strong) NSString *winningSnippetId;

// optional (and mutable) attributes
@property (nonatomic, strong) NSMutableDictionary *voteData;

#pragma mark - Methods

/** Returns RoundBuilder with all fields initialized based on dictionary data, unless data is missing values,
 * in which case it initializes a RoundBuilder the same way as init does.
 */
- (instancetype)initWithId:(NSString *)roundId
                dictionary:(NSDictionary *)data
               submissions:(NSMutableArray *)submissions;

/** Returns RoundBuilder with all fields initialized as a copy of a Round model. */
- (instancetype)initWithRound:(Round *)round;

- (RoundBuilder *)withId:(NSString *)roundId;

- (RoundBuilder *)withCreatedAt:(NSDate *)createdAt;

- (RoundBuilder *)markComplete;

- (RoundBuilder *)withEndTime:(NSDate *)endTime;

- (RoundBuilder *)withSubmissions:(NSMutableArray<Snippet *> *)submissions;

- (RoundBuilder *)addSubmission:(Snippet *)snippet;

- (RoundBuilder *)updateExistingSubmissionWithSubmission:(Snippet *)updatedSnippet;

- (RoundBuilder *)updateRoundVoteCountBy:(NSInteger)numOfNewVotes
                                 forUser:(User *)user;

- (RoundBuilder *)withWinningSnippetId:(NSString *)winningSnippetId;

/** Returns fully built Round if RoundBuilder has all fields initialized properly. Else returns nil. */
- (Round *)build;

/** Returns Roundbuilder if round contains at least one submission, hasn't already been marked as complete, submissions have been ranked,
 * and current time is past specified round end time. Else returns nil.
 */
- (RoundBuilder *)markCompleteAndSetWinningSnippet;

/** Returns RoundBuilder if round contains no submissions, hasn't been marked as complete,
 * and current time is past specified round end time. Else returns nil.
 */
- (RoundBuilder *)extendEndTime;

@end

NS_ASSUME_NONNULL_END
