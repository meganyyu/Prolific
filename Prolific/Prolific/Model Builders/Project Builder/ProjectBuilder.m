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
static NSString *const kFollowCountKey = @"followCount";
static NSString *const kUsersFollowingKey = @"usersFollowing";

@implementation ProjectBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _projectId = nil;
        _name = nil;
        _createdAt = [ProlificUtils convertTimestampToDate:[FIRTimestamp timestamp]];
        _seed = nil;
        _currentRound = [NSNumber numberWithInt:0];
        _isComplete = NO;
        _rounds = [[NSMutableArray alloc] init];
        _followCount = 0;
        _userFollowed = NO;
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
            _rounds = [rounds mutableCopy];
            _name = data[kNameKey];
            _createdAt = [ProlificUtils convertTimestampToDate:data[kCreatedAtKey]];
            _seed = data[kSeedKey];
            _currentRound = data[kCurrentRoundKey];
            _isComplete = data[kIsCompleteKey];
            _followCount = data[kFollowCountKey];
            
            if ([[data objectForKey:kUsersFollowingKey] isKindOfClass:[NSArray class]]) {
                NSString *const currUserId = [FIRAuth auth].currentUser.uid;
                _userFollowed = [data[kUsersFollowingKey] containsObject:currUserId];
            }
        }
    }
    return self;
}

- (instancetype)initWithProject:(Project *)project {
    self = [self init];
    
    if (self) {
        _projectId = project.projectId;
        _name = project.name;
        _createdAt = project.createdAt;
        _seed = project.seed;
        _currentRound = project.currentRound;
        _isComplete = project.isComplete;
        _rounds = [project.rounds mutableCopy];
        _followCount = project.followCount;
        _userFollowed = project.userFollowed;
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

- (ProjectBuilder *)incrementCurrentRoundNumber {
    _currentRound = [NSNumber numberWithInt:[_currentRound intValue] + 1];
    return self;
}

- (ProjectBuilder *)withFollowCount:(NSNumber *)followCount {
    _followCount = followCount;
    return self;
}

- (ProjectBuilder *)updateCurrentUserFollowing {
    _userFollowed = !_userFollowed;
    _followCount = [NSNumber numberWithInt:[_followCount intValue] + (_userFollowed ? 1 : -1)];
    
    return self;
}

- (ProjectBuilder *)markComplete {
    _isComplete = YES;
    return self;
}

- (ProjectBuilder *)withRounds:(NSMutableArray<Round *> *)rounds {
    _rounds = [rounds mutableCopy];
    return self;
}

- (ProjectBuilder *)updateLatestRound:(Round *)updatedRound {
    int latestRoundNumber = (int) _rounds.count - 1;
    if (latestRoundNumber >= 0) {
        _rounds[latestRoundNumber] = updatedRound;
        return self;
    }
    return nil;
}

- (ProjectBuilder *)addRound:(Round *)round {
    [_rounds addObject:round];
    return self;
}

- (Project *)build {
    if (_projectId && _name && _createdAt && _seed && _currentRound && _rounds && _followCount) {
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
    [ProlificUtils isBoolNumber:[data objectForKey:kIsCompleteKey]] &&
    [[data objectForKey:kFollowCountKey] isKindOfClass:[NSNumber class]];
}

@end
