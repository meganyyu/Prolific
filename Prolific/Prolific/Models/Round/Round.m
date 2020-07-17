//
//  Round.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Round.h"

@implementation Round

#pragma mark - Initializer

- (instancetype)initWithBuilder:(RoundBuilder *)builder {
    self = [super init];
    if (self) {
        _roundId = builder.roundId;
        _isComplete = builder.isComplete;
        _submissions = builder.submissions;
        _winningSnippetId = builder.winningSnippetId;
    }
    return self;
}

@end
