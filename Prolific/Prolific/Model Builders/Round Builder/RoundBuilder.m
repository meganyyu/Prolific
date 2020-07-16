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
        
    }
    return self;
}

- (RoundBuilder *)withId:(NSString *)roundId {
    _roundId = roundId;
    return self;
}

- (RoundBuilder *)addSubmission:(Snippet *)snippet {
    [_submissions addObject:snippet];
    return self;
}

- (Round *)build {
    Round *round = [[Round alloc] initWithBuilder:self];
    return round;
}

@end
