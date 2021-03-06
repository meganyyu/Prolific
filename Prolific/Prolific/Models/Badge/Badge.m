//
//  Badge.m
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Badge.h"

@implementation Badge

#pragma mark - Initializer

- (instancetype)initWithBuilder:(BadgeBuilder *)builder {
    self = [super init];
    if (self) {
        _badgeType = builder.badgeType;
        _badgeName = builder.badgeName;
        _level = builder.level;
        _goalCompletedSoFar = builder.goalCompletedSoFar;
        _totalGoal = builder.totalGoal;
        _metricType = builder.metricType;
        _actionType = builder.actionType;
    }
    return self;
}

@end
