//
//  Round.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Round.h"

@import Firebase;

@implementation Round

#pragma mark - Initializer

- (instancetype)initWithBuilder:(RoundBuilder *)builder {
    self = [super init];
    if (self) {
        _roundId = builder.roundId;
        _isComplete = builder.isComplete;
        _createdAt = builder.createdAt;
        _endTime = builder.endTime;
        _submissions = builder.submissions;
        _winningSnippetId = builder.winningSnippetId;
    }
    return self;
}

/** Only returns true if round contains at least one submission, hasn't already been marked as complete, and current time is past specified round end time. */
- (BOOL)needToMarkAsComplete {
    NSDate *const currTime = [FIRTimestamp timestamp].dateValue;
    if (!_isComplete &&
        _submissions.count > 0 &&
        [currTime timeIntervalSinceDate:_endTime] > 0) {
        return YES;
    }
    return NO;
}

/** Only returns true if round contains no submissions, hasn't been marked as complete, and current time is past specified round end time. */
- (BOOL)needToExtendTime {
    NSDate *const currTime = [FIRTimestamp timestamp].dateValue;
    if (!_isComplete &&
        _submissions.count == 0 &&
        [currTime timeIntervalSinceDate:_endTime] > 0) {
        return YES;
    }
    return NO;
}

/** Only extends the end time by 1 day if there are no submissions in the round. */
- (BOOL)extendEndTime {
    if (_submissions.count == 0) {
        NSDateComponents *const dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        NSLog(@"Extending deadline! End time is originally: %@", _endTime);
        NSCalendar *const currCalendar = [NSCalendar currentCalendar];
        NSDate *const extendedEndTime = [currCalendar dateByAddingComponents:dayComponent toDate:_endTime options:0];
        
        _endTime = extendedEndTime;
        NSLog(@"New end time is: %@", _endTime);
        return YES;
    }
    return NO;
}

/** Only marks a round as complete and sets a winning snippet Id if the round is ready and hasn't already been marked as complete. */
- (BOOL)markCompleteAndSetWinningSnippet {
    if ([self needToMarkAsComplete]) {
        _isComplete = YES;
        
        Snippet *winningSnippetSoFar = _submissions[0];
        
        for (Snippet *const snippet in _submissions) {
            if (snippet.voteCount > winningSnippetSoFar.voteCount) {
                winningSnippetSoFar = snippet;
            }
        }
        _winningSnippetId = winningSnippetSoFar.snippetId;
        return YES;
    }
    return NO;
}

@end
