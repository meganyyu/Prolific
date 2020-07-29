//
//  RoundRanker.m
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundRanker.h"

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

@end
