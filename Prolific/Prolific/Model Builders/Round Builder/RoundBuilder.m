//
//  RoundBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundBuilder.h"

@import Firebase;

static NSString *const kCreatedAtKey = @"createdAt";
static NSString *const kEndTimeKey = @"endTime";
static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kWinningSnippetIdKey = @"winningSnippetId";

@implementation RoundBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _roundId = nil;
        _createdAt = [ProlificUtils convertTimestampToDate:[FIRTimestamp timestamp]];
        _isComplete = NO;
        _endTime = [ProlificUtils convertTimestampToDate:[FIRTimestamp timestamp]];
        _submissions = [[NSMutableArray alloc] init];
        _winningSnippetId = nil;
    }
    return self;
}

- (instancetype)initWithId:(NSString *)roundId
                dictionary:(NSDictionary *)data
               submissions:(NSMutableArray *)submissions {
    self = [self init];
    
    if (self) {
        if (roundId && submissions &&
            [self validateRequiredDictionaryData:data]) {
            _roundId = roundId;
            _submissions = submissions;
            _isComplete = [data[kIsCompleteKey] boolValue];
            _createdAt = [ProlificUtils convertTimestampToDate:data[kCreatedAtKey]];
            _endTime = [ProlificUtils convertTimestampToDate:data[kEndTimeKey]];
        }
        if ([[data objectForKey:kWinningSnippetIdKey] isKindOfClass:[NSString class]]) {
            _winningSnippetId = data[kWinningSnippetIdKey];
        }
    }
    return self;
}

- (instancetype)initWithRound:(Round *)round {
    self = [self init];
    
    if (self) {
        _roundId = round.roundId;
        _createdAt = round.createdAt;
        _isComplete = round.isComplete;
        _endTime = round.endTime;
        _submissions = round.submissions;
        _winningSnippetId = round.winningSnippetId;
    }
    return self;
}

- (RoundBuilder *)withId:(NSString *)roundId {
    _roundId = roundId;
    return self;
}

- (RoundBuilder *)withCreatedAt:(NSDate *)createdAt {
    _createdAt = createdAt;
    return self;
}

- (RoundBuilder *)markComplete {
    _isComplete = YES;
    return self;
}

- (RoundBuilder *)withEndTime:(NSDate *)endTime {
    _endTime = endTime;
    return self;
}

- (RoundBuilder *)withSubmissions:(NSMutableArray<Snippet *> *)submissions {
    _submissions = submissions;
    return self;
}

- (RoundBuilder *)addSubmission:(Snippet *)snippet {
    [_submissions addObject:snippet];
    return self;
}

- (RoundBuilder *)withWinningSnippetId:(NSString *)winningSnippetId {
    _winningSnippetId = winningSnippetId;
    return self;
}

- (Round *)build {
    if (_roundId && _submissions && _createdAt && _endTime) {
        Round *round = [[Round alloc] initWithBuilder:self];
        return round;
    }
    return nil;
}

#pragma mark - Round completion

- (RoundBuilder *)markCompleteAndSetWinningSnippet {
    if ([self needToMarkAsComplete]) {
        _isComplete = YES;
        
        Snippet *winningSnippetSoFar = _submissions[0];
        
        for (Snippet *const snippet in _submissions) {
            if (snippet.voteCount > winningSnippetSoFar.voteCount) {
                winningSnippetSoFar = snippet;
            }
        }
        _winningSnippetId = winningSnippetSoFar.snippetId;
        return self;
    }
    return nil;
}

- (RoundBuilder *)extendEndTime {
    if ([self needToExtendTime]) {
        NSDateComponents *const dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        NSLog(@"Extending deadline! End time is originally: %@", _endTime);
        NSCalendar *const currCalendar = [NSCalendar currentCalendar];
        NSDate *const extendedEndTime = [currCalendar dateByAddingComponents:dayComponent toDate:_endTime options:0];
        
        _endTime = extendedEndTime;
        NSLog(@"New end time is: %@", _endTime);
        return self;
    }
    return nil;
}

#pragma mark - Helper functions

/** Validates that the data passed in through a dictionary is valid. */
- (BOOL)validateRequiredDictionaryData:(NSDictionary *)data {
    return [[data objectForKey:kIsCompleteKey] isKindOfClass:[NSNumber class]] &&
    [ProlificUtils isBoolNumber:[data objectForKey:kIsCompleteKey]] &&
    [[data objectForKey:kCreatedAtKey] isKindOfClass:[FIRTimestamp class]] &&
    [[data objectForKey:kEndTimeKey] isKindOfClass:[FIRTimestamp class]];
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

@end
