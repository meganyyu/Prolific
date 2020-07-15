//
//  ThreadBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ThreadBuilder.h"

@implementation ThreadBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _threadId = @"testThreadId";
        _name = @"testThreadName";
        _isComplete = false;
        _rounds = [[NSMutableArray alloc] init]; // FIXME: should initialize with a round already in it
    }
    return self;
}

- (ThreadBuilder *)withId:(NSString *)threadId {
    _threadId = threadId;
    return self;
}

- (ThreadBuilder *)withName:(NSString *)threadName {
    _name = threadName;
    return self;
}

- (ThreadBuilder *)addRound:(Round *)round {
    [_rounds addObject:round];
    return self;
}

- (Thread *)build {
    Thread *thread = [[Thread alloc] initWithBuilder:self];
    return thread;
}

@end
