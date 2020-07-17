//
//  RoundBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundBuilder.h"

static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kWinningSnippetIdKey = @"winningSnippetId";

@implementation RoundBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _roundId = nil;
        _isComplete = NO;
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
            [data objectForKey:kIsCompleteKey] &&
            [data objectForKey:kWinningSnippetIdKey]) {
            _roundId = roundId;
            _submissions = submissions;
            _isComplete = data[kIsCompleteKey];
            _winningSnippetId = data[kWinningSnippetIdKey];
        }
    }
    return self;
}

- (RoundBuilder *)withId:(NSString *)roundId {
    _roundId = roundId;
    return self;
}

- (RoundBuilder *)isComplete:(BOOL)value {
    _isComplete = value;
    return self;
}

- (RoundBuilder *)withSubmissions:(NSMutableArray<Snippet *> *)submissions {
    _submissions = submissions;
    return self;
}

- (RoundBuilder *)withWinningSnippetId:(NSString *)winningSnippetId {
    _winningSnippetId = winningSnippetId;
    return self;
}

- (Round *)build {
    if (_roundId && _submissions) {
        Round *round = [[Round alloc] initWithBuilder:self];
        return round;
    }
    return nil;
}

@end
