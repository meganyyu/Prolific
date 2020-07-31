//
//  RoundRanker.h
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project.h"
#import "Round.h"
#import "Snippet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundRanker : NSObject

/** Returns a Round model with all the submissions' scores and ranks calculated and updated. Also update's Round's winning snippet id so far. */
+ (Round *)updateRanksForRound:(Round *)round;

+ (NSArray *)rankSubmissionsForScores:(NSDictionary *)scores;

+ (NSDictionary *)scoreSubmissionsForRound:(Round *)round;

+ (NSDecimalNumber *)calculateScoreForSubmission:(Snippet *)snippet withVoteWeights:(NSDictionary *)voteWeights;

+ (NSDictionary *)computeVoteWeightsForRound:(Round *)round;

@end

NS_ASSUME_NONNULL_END
