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

- (BOOL)needToMarkAsComplete {
    NSDate *const currTime = [FIRTimestamp timestamp].dateValue;
    if (!_isComplete &&
        _submissions.count > 0 &&
        [currTime timeIntervalSinceDate:_endTime] > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)needToExtendTime {
    NSDate *const currTime = [FIRTimestamp timestamp].dateValue;
    if (!_isComplete &&
        _submissions.count == 0 &&
        [currTime timeIntervalSinceDate:_endTime] > 0) {
        return YES;
    }
    return NO;
}

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
