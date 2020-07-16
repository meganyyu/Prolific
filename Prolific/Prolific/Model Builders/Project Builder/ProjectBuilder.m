//
//  ProjectBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectBuilder.h"

@implementation ProjectBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _projectId = nil;
        _name = nil;
        _seed = nil;
        _currentRound = nil;
        _isComplete = false;
        _rounds = [[NSMutableArray alloc] init]; // FIXME: should initialize with a round already in it
    }
    return self;
}

- (ProjectBuilder *)withId:(NSString *)projectId {
    _projectId = projectId;
    return self;
}

- (ProjectBuilder *)withName:(NSString *)projectName {
    _name = projectName;
    return self;
}

- (ProjectBuilder *)withSeed:(NSString *)seed {
    _seed = seed;
    return self;
}

- (ProjectBuilder *)withCurrentRound:(NSNumber *)roundNumber {
    _currentRound = roundNumber;
    return self;
}

- (ProjectBuilder *)isComplete:(BOOL)value {
    _isComplete = value;
    return self;
}

- (ProjectBuilder *)addRound:(Round *)round {
    [_rounds addObject:round];
    return self;
}

- (Project *)build {
    if (_projectId && _name && _seed && _currentRound) {
        Project *proj = [[Project alloc] initWithBuilder:self];
        return proj;
    }
    return nil;
}

@end
