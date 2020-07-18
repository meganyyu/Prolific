//
//  ProjectBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectBuilder.h"

static NSString *const kCreatedAtKey = @"createdAt";
static NSString *const kCurrentRoundKey = @"currentRound";
static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kNameKey = @"name";
static NSString *const kSeedKey = @"seed";

@implementation ProjectBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _projectId = nil;
        _name = nil;
        _createdAt = nil;
        _seed = nil;
        _currentRound = nil;
        _isComplete = NO;
        _rounds = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithId:(NSString *)projectId
                dictionary:(NSDictionary *)data
                    rounds:(NSMutableArray *)rounds {
    self = [self init];
    
    if (self) {
        if (projectId && rounds &&
            [data objectForKey:kNameKey] &&
            [data objectForKey:kCreatedAtKey] &&
            [data objectForKey:kSeedKey] &&
            [data objectForKey:kCurrentRoundKey] &&
            [data objectForKey:kIsCompleteKey]) {
            _projectId = projectId;
            _name = data[kNameKey];
            _seed = data[kSeedKey];
            _currentRound = data[kCurrentRoundKey];
            _isComplete = data[kIsCompleteKey];
            _rounds = rounds;
        }
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

- (ProjectBuilder *)withCreatedAt:(NSDate *)createdAt {
    _createdAt = createdAt;
    return self;
}

- (ProjectBuilder *)withSeed:(NSString *)seed {
    _seed = seed;
    return self;
}

- (ProjectBuilder *)withCurrentRoundNumber:(NSNumber *)roundNumber {
    _currentRound = roundNumber;
    return self;
}

- (ProjectBuilder *)isComplete:(BOOL)value {
    _isComplete = value;
    return self;
}

- (ProjectBuilder *)withRounds:(NSMutableArray<Round *> *)rounds {
    _rounds = rounds;
    return self;
}

- (Project *)build {
    if (_projectId && _name && _createdAt && _seed && _currentRound && _rounds) {
        Project *proj = [[Project alloc] initWithBuilder:self];
        return proj;
    }
    return nil;
}

@end
