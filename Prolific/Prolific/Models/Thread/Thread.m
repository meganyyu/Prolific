//
//  Thread.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Thread.h"

@implementation Thread

- (id)initWithBuilder:(ThreadBuilder *)builder {
    self = [super init];
    if (self) {
        _threadId = builder.threadId;
        _threadName = builder.name;
        _isComplete = builder.isComplete;
        _rounds = builder.rounds;
    }
    return self;
}

@end
