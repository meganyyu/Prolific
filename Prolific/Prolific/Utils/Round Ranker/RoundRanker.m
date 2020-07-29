//
//  RoundRanker.m
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundRanker.h"

static NSString *const kVoteCountKey = @"voteCount";
static NSString *const kCurrentKarmaKey = @"currentKarma";

@implementation RoundRanker

+ (NSArray *)rankSubmissionsForRound:(Round *)round {
    return nil;
}

+ (NSDictionary *)scoreSubmissionsForRound:(Round *)round {
    NSMutableDictionary *const scores = [[NSMutableDictionary alloc] init];
    for (Snippet *const submission in round.submissions) {
        NSDecimalNumber *const score = [RoundRanker calculateScoreForSubmission:submission];
        [scores setObject:score forKey:submission.snippetId];
    }
    return scores;
}

+ (NSDecimalNumber *)calculateScoreForSubmission:(Snippet *)snippet {
    return 0;
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
