//
//  BadgeBuilder.m
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BadgeBuilder.h"

#pragma mark - Badge Types

static NSString *const kContributorBadgeId = @"contributor-badge";
static NSString *const kBigHitWriterBadgeId = @"big-hit-writer-badge";
static NSString *const kCreatorBadgeId = @"creator-badge";

#pragma mark - Keys

static NSString *const kActionTypeKey = @"actionType";
static NSString *const kBadgeNameKey = @"badgeName";
static NSString *const kGoalCompletedSoFarKey = @"goalCompletedSoFar";
static NSString *const kLevelKey = @"level";
static NSString *const kMetricTypeKey = @"metricType";
static NSString *const kTotalGoalKey = @"totalGoal";

#pragma mark - Badge-specific Values

static NSString *const contributorBadgeName = @"Contributor";
static NSString *const bigHitWriterBadgeName = @"Big Hit Writer";
static NSString *const creatorBadgeName = @"Creator";
static NSInteger const contributorBadgeGoal = 50;
static NSInteger const bigHitWriterBadgeGoal = 20;
static NSInteger const creatorBadgeGoal = 20;
static NSString *const contributorBadgeMetricType = @"snippets";
static NSString *const bigHitWriterBadgeMetricType = @"rounds";
static NSString *const creatorBadgeMetricType = @"projects";
static NSString *const contributorBadgeActionType = @"submit";
static NSString *const bigHitWriterBadgeActionType = @"win";
static NSString *const creatorBadgeActionType = @"create";

#pragma mark - Implementation

@implementation BadgeBuilder

- (id)initWithBadgeType:(NSString *)badgeType {
    self = [super init];
    if (self) {
        _badgeType = badgeType;
        _level = [NSNumber numberWithInt:1];
        _goalCompletedSoFar = [NSNumber numberWithInt:0];
        
        if ([badgeType isEqualToString:kContributorBadgeId]) {
            _badgeName = contributorBadgeName;
            _totalGoal = [NSNumber numberWithInt:contributorBadgeGoal];
            _metricType = contributorBadgeMetricType;
            _actionType = contributorBadgeActionType;
        } else if ([badgeType isEqualToString:kBigHitWriterBadgeId]) {
            _badgeName = bigHitWriterBadgeName;
            _totalGoal = [NSNumber numberWithInt:bigHitWriterBadgeGoal];
            _metricType = bigHitWriterBadgeMetricType;
            _actionType = bigHitWriterBadgeActionType;
        } else if ([badgeType isEqualToString:kCreatorBadgeId]) {
            _badgeName = creatorBadgeName;
            _totalGoal = [NSNumber numberWithInt:creatorBadgeGoal];
            _metricType = creatorBadgeMetricType;
            _actionType = creatorBadgeActionType;
        } else {
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithBadgeType:(NSString *)badgeType
                       dictionary:(NSDictionary *)data {
    self = [self initWithBadgeType:badgeType];
    if (self) {
        if ([self validateRequiredDictionaryData:data]) {
            _badgeName = data[kBadgeNameKey];
            _level = data[kLevelKey];
            _goalCompletedSoFar = data[kGoalCompletedSoFarKey];
            _totalGoal = data[kTotalGoalKey];
            _metricType = data[kMetricTypeKey];
            _actionType = data[kActionTypeKey];
        }
    }
    return self;
}

- (instancetype)initWithBadge:(Badge *)badge {
    self = [self initWithBadgeType:badge.badgeType];
    
    if (self) {
        _badgeName = badge.badgeName;
        _level = badge.level;
        _goalCompletedSoFar = badge.goalCompletedSoFar;
        _totalGoal = badge.totalGoal;
        _metricType = badge.metricType;
        _actionType = badge.actionType;
    }
    return self;
}

- (BadgeBuilder *)withBadgeType:(NSString *)badgeType {
    _badgeType = badgeType;
    return self;
}

- (BadgeBuilder *)withBadgeName:(NSString *)badgeName {
    _badgeName = badgeName;
    return self;
}

- (BadgeBuilder *)withMetricType:(NSString *)metricType {
    _metricType = metricType;
    return self;
}

- (BadgeBuilder *)withActionType:(NSString *)actionType {
    _actionType = actionType;
    return self;
}

- (BadgeBuilder *)withLevel:(NSNumber *)level {
    _level = level;
    return self;
}

- (BadgeBuilder *)levelUp {
    _level = [NSNumber numberWithLong:[_level intValue] + 1];
    return self;
}

- (BadgeBuilder *)withGoalCompletedSoFar:(NSNumber *)goalCompletedSoFar {
    _goalCompletedSoFar = goalCompletedSoFar;
    return self;
}

- (BadgeBuilder *)addToGoal:(NSInteger)amount {
    _goalCompletedSoFar = [NSNumber numberWithLong:[_goalCompletedSoFar intValue] + amount];
    if (_goalCompletedSoFar >= _totalGoal) {
        _goalCompletedSoFar = 0;
        _level = [NSNumber numberWithLong:[_level intValue] + 1];
    }
    return self;
}

- (BadgeBuilder *)withTotalGoal:(NSNumber *)totalGoal {
    _totalGoal = totalGoal;
    return self;
}

- (Badge *)build {
    if (_badgeType && _badgeName && _level && _goalCompletedSoFar && _totalGoal && _metricType && _actionType) {
        Badge *badge = [[Badge alloc] initWithBuilder:self];
        return badge;
    }
    return nil;
}

#pragma mark - Helper functions

/** Validates that the data passed in through a dictionary is valid. */
- (BOOL)validateRequiredDictionaryData:(NSDictionary *)data {
    return [[data objectForKey:kBadgeNameKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kLevelKey] isKindOfClass:[NSNumber class]] &&
    [[data objectForKey:kGoalCompletedSoFarKey] isKindOfClass:[NSNumber class]] &&
    [[data objectForKey:kTotalGoalKey] isKindOfClass:[NSNumber class]] &&
    [[data objectForKey:kMetricTypeKey] isKindOfClass:[NSString class]] &&
    [[data objectForKey:kActionTypeKey] isKindOfClass:[NSString class]];
}

@end
