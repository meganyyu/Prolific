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
@property (nonatomic, strong) NSString *seed;

// required (and mutable) attributes
@property (nonatomic) BOOL isComplete;
@property (nonatomic, strong) NSNumber *currentRound;

// optional (and mutable) attributes
@property (nonatomic, strong, nullable) NSMutableArray<Round *> *rounds;

- (ProjectBuilder *)withId:(NSString *)projectId;

- (ProjectBuilder *)withName:(NSString *)projectName;

- (ProjectBuilder *)withSeed:(NSString *)seed;

- (ProjectBuilder *)withCurrentRound:(NSNumber *)roundNumber;

- (ProjectBuilder *)isComplete:(BOOL)value;

- (ProjectBuilder *)addRound:(NSString *)aRound;

- (Project *)build;

@end

NS_ASSUME_NONNULL_END
