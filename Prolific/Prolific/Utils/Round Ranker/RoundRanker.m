//
//  RoundRanker.m
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundRanker.h"

#import "DAO.h"

static NSString *const kVoteCountKey = @"voteCount";
static NSString *const kCurrentKarmaKey = @"currentKarma";

#pragma mark - Implementation

@implementation RoundRanker

+ (Round *)updateRanksForRound:(Round *)round {
    NSDictionary *const scores = [RoundRanker scoreSubmissionsForRound:round];
    NSArray *const rankedSnippetIds = [RoundRanker rankSubmissionsForScores:scores];
    
    RoundBuilder *roundBuilder = [[[RoundBuilder alloc] initWithRound:round]
                                  withWinningSnippetId:rankedSnippetIds[0]];
    
    for (Snippet *snippet in round.submissions) {
        NSNumber *const rank = [NSNumber numberWithLong:[rankedSnippetIds indexOfObject:snippet.snippetId] + 1];
        NSDecimalNumber *const score = [scores valueForKey:snippet.snippetId];
        
        Snippet *const updatedSnippet = [[[[[SnippetBuilder alloc] initWithSnippet:snippet]
                                           withRank:rank]
                                          withScore:score]
                                         build];
        roundBuilder = [roundBuilder updateExistingSubmissionWithSubmission:updatedSnippet];
    }
    
    return [roundBuilder build];
}

+ (NSArray *)rankSubmissionsForScores:(NSDictionary *)scores {
    return [scores keysSortedByValueUsingSelector:@selector(comparator)];
}

+ (NSDictionary *)scoreSubmissionsForRound:(Round *)round {
    NSMutableDictionary *const scores = [[NSMutableDictionary alloc] init];
    NSDictionary *const voteWeights = [RoundRanker computeVoteWeightsForRound:round];
    
    for (Snippet *const submission in round.submissions) {
        NSDecimalNumber *const score = [RoundRanker calculateScoreForSubmission:submission withVoteWeights:voteWeights];
        [scores setValue:score forKey:submission.snippetId];
    }
    return scores;
}

+ (NSDecimalNumber *)calculateScoreForSubmission:(Snippet *)snippet withVoteWeights:(NSDictionary *)voteWeights {
    NSDecimalNumber *totalScore = [NSDecimalNumber zero];
    
    for (NSString *const userId in snippet.userVotes) {
        NSDecimalNumber *voteWeight = [voteWeights valueForKey:userId];
        
        if (voteWeight != nil) {
            totalScore = [totalScore decimalNumberByAdding:voteWeight];
        }
    }
    return totalScore;
}

+ (NSDictionary *)computeVoteWeightsForRound:(Round *)round {
    NSMutableDictionary *const voteWeights = [[NSMutableDictionary alloc] init];
    
    for (id userId in round.voteData) {
        NSDictionary *const userVoteData = [round.voteData objectForKey:userId];
        
        NSDecimalNumber *const voteCount = [NSDecimalNumber decimalNumberWithDecimal:[userVoteData[kVoteCountKey] decimalValue]];
        NSDecimalNumber *const currentKarma = [NSDecimalNumber decimalNumberWithDecimal:[userVoteData[kCurrentKarmaKey] decimalValue]];
        
        if ([voteCount compare:[NSNumber numberWithInt:0]] != NSOrderedSame) {
            NSDecimalNumber *const voteWeight = [currentKarma decimalNumberByDividingBy:voteCount];
            
            [voteWeights setValue:voteWeight forKey:userId];
        }
    }
    
    return voteWeights;
}

@end
