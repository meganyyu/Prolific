//
//  ProjectBuilder.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectBuilder.h"

@import Firebase;

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
        _createdAt = [FIRTimestamp timestamp].dateValue;
        _seed = nil;
        _currentRound = [NSNumber numberWithInt:0];
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
            [self validateRequiredDictionaryData:data]) {
            _projectId = projectId;
            _rounds = rounds;
            _name = data[kNameKey];
            _createdAt = data[kCreatedAtKey];
            _seed = data[kSeedKey];
            _currentRound = data[kCurrentRoundKey];
            _isComplete = data[kIsCompleteKey];
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

#pragma mark - Helper functions

- (BOOL)validateRequiredDictionaryData:(NSDictionary *)data {
    return [[data objectForKey:kNameKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kCreatedAtKey] isKindOfClass:[FIRTimestamp class]] &&
    [[data objectForKey:kSeedKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kCurrentRoundKey] isKindOfClass:[NSNumber class]] &&
    [[data objectForKey:kIsCompleteKey] isKindOfClass:[NSNumber class]] &&
    [self isBoolNumber:[data objectForKey:kIsCompleteKey]];
}

- (BOOL)isBoolNumber:(NSNumber *)num
{
   CFTypeID boolID = CFBooleanGetTypeID();
   CFTypeID numID = CFGetTypeID((__bridge CFTypeRef)(num));
   return numID == boolID;
}

@end
