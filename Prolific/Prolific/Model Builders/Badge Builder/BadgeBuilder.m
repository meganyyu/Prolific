//
//  BadgeBuilder.m
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BadgeBuilder.h"

#pragma mark - Badge Types

static NSString *const kWriterBadgeId = @"writer-badge";
static NSString *const kBigHitBadgeId = @"big-hit-badge";
static NSString *const kCreatorBadgeId = @"creator-badge";

#pragma mark - Keys

static NSString *const kLevelKey = @"username";
static NSString *const kGoalCompletedSoFarKey = @"goalCompletedSoFar";
static NSString *const kTotalGoalKey = @"totalGoal";

#pragma mark - Implementation

@implementation BadgeBuilder

- (id)initWithType:(NSString *)badgeType {
    self = [super init];
    if (self) {
        _level = [NSNumber numberWithInt:1];
        _goalCompletedSoFar = [NSNumber numberWithInt:0];
        
        if ([badgeType isEqualToString:kWriterBadgeId]) {
            _totalGoal = [NSNumber numberWithInt:50];
        } else if ([badgeType isEqualToString:kBigHitBadgeId]) {
            _totalGoal = [NSNumber numberWithInt:20];
        } else if ([badgeType isEqualToString:kCreatorBadgeId]) {
            _totalGoal = [NSNumber numberWithInt:20];
        } else {
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithType:(NSString *)badgeType dictionary:(NSDictionary *)data {
    self = [self initWithType:badgeType];
    
    if (self) {
        if ([self validateRequiredDictionaryData:data]) {
            _level = data[kLevelKey];
            _goalCompletedSoFar = data[kGoalCompletedSoFarKey];
            _totalGoal = data[kTotalGoalKey];
        }
    }
    return self;
}

- (instancetype)initWithBadge:(Badge *)badge {
    self = [self init];
    
    if (self) {
        _badgeType = badge.badgeType;
        _level = badge.level;
        _goalCompletedSoFar = badge.goalCompletedSoFar;
        _totalGoal = badge.totalGoal;
    }
    return self;
}

- (BadgeBuilder *)withType:(NSString *)badgeType {
    _badgeType = badgeType;
    return self;
}

- (BadgeBuilder *)withLevel:(NSNumber *)level {
    _level = level;
    return self;
}

- (BadgeBuilder *)withGoalCompletedSoFar:(NSNumber *)goalCompletedSoFar {
    _goalCompletedSoFar = goalCompletedSoFar;
    return self;
}

- (BadgeBuilder *)addToGoal:(NSInteger)amount {
    _goalCompletedSoFar = [NSNumber numberWithLong:[_goalCompletedSoFar intValue] + amount];
    return self;
}

- (BadgeBuilder *)withTotalGoal:(NSNumber *)totalGoal {
    _totalGoal = totalGoal;
    return self;
}

- (Badge *)build {
    if (_badgeType && _level && _goalCompletedSoFar && _totalGoal) {
        Badge *badge = [[Badge alloc] initWithBuilder:self];
        return badge;
    }
    return nil;
}

#pragma mark - Helper functions

/** Validates that the data passed in through a dictionary is valid. */
- (BOOL)validateRequiredDictionaryData:(NSDictionary *)data {
    return [[data objectForKey:kLevelKey] isKindOfClass:[NSNumber class]] &&
    [[data objectForKey:kGoalCompletedSoFarKey] isKindOfClass:[NSNumber class]] &&
    [[data objectForKey:kTotalGoalKey] isKindOfClass:[NSNumber class]];
}

@end
