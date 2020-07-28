//
//  Project.m
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Project.h"

@implementation Project

- (id)initWithBuilder:(ProjectBuilder *)builder {
    self = [super init];
    if (self) {
        _projectId = builder.projectId;
        _name = builder.name;
        _createdAt = builder.createdAt;
        _seed = builder.seed;
        _currentRound = builder.currentRound;
        _isComplete = builder.isComplete;
        _rounds = builder.rounds;
        _followCount = builder.followCount;
        _userFollowed = builder.userFollowed;
    }
    return self;
}

- (void)updateCurrentUserFollowing {
    _userFollowed = !_userFollowed;
    _followCount = [NSNumber numberWithInt:[_followCount intValue] + (_userFollowed ? 1 : -1)];
}

@end
