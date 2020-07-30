//
//  ProjectBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Project;

#import "Entity.h"

#import "Project.h"
#import "Round.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectBuilder : EntityBuilder

// required (and immutable) attributes
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *seed;

// required (and mutable) attributes
@property (nonatomic) BOOL isComplete;
@property (nonatomic, strong) NSNumber *currentRound;
@property (nonatomic, strong) NSMutableArray<Round *> *rounds;
@property (nonatomic, strong) NSNumber *followCount;
@property (nonatomic) BOOL userFollowed;

/** Returns ProjectBuilder with all fields initialized based on dictionary data, unless data is missing values, in which case it initializes a ProjectBuilder the same way as init does. */
- (instancetype)initWithId:(NSString *)projectId
                dictionary:(NSDictionary *)data
                    rounds:(NSMutableArray *)rounds;

/** Returns ProjectBuilder with all fields initialized as a copy of a Project model. */
- (instancetype)initWithProject:(Project *)project;

- (ProjectBuilder *)withId:(NSString *)projectId;

- (ProjectBuilder *)withName:(NSString *)projectName;

- (ProjectBuilder *)withCreatedAt:(NSDate *)createdAt;

- (ProjectBuilder *)withSeed:(NSString *)seed;

- (ProjectBuilder *)incrementCurrentRoundNumber;

- (ProjectBuilder *)withFollowCount:(NSNumber *)followCount;

- (ProjectBuilder *)updateCurrentUserFollowing;

- (ProjectBuilder *)markComplete;

- (ProjectBuilder *)withRounds:(NSMutableArray<Round *> *)rounds;

- (ProjectBuilder *)updateLatestRound:(Round *)updatedRound;

- (ProjectBuilder *)addRound:(Round *)round;

/** Returns fully built Project if ProjectBuilder has all fields initialized properly. Else returns nil. */
- (Project *)build;

@end

NS_ASSUME_NONNULL_END
