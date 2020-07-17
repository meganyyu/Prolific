//
//  RoundBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "RoundBuilder.h"

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

- (RoundBuilder *)withId:(NSString *)roundId {
    _roundId = roundId;
    return self;
}

- (RoundBuilder *)isComplete:(BOOL)value {
    _isComplete = value;
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
    if (_roundId && _submissions) {
        Round *round = [[Round alloc] initWithBuilder:self];
        return round;
    }
    return nil;
}

@end
