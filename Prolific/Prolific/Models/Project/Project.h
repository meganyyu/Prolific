//
//  Project.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class ProjectBuilder;

#import "Entity.h"

#import "Round.h"
#import "ProjectBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Project : Entity

#pragma mark - Properties

// required (and immutable) attributes
@property (nonatomic, strong, readonly) NSString *projectId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) NSString *seed;

// required (and mutable) attributes
@property (nonatomic, readonly) BOOL isComplete;
@property (nonatomic, strong, readonly) NSNumber *currentRound;
@property (nonatomic, strong) NSMutableArray<Round *> *rounds;

#pragma mark - Methods

- (instancetype)initWithBuilder:(ProjectBuilder *)builder;

@end

NS_ASSUME_NONNULL_END
