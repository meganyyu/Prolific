//
//  Badge.h
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class BadgeBuilder;

#import "Entity.h"

#import "BadgeBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Badge : Entity

#pragma mark - Properties

// required (and immutable) attributes
@property (nonatomic, strong, readonly) NSString *badgeType;

// required (and mutable) attributes
@property (nonatomic, strong, readonly) NSNumber *level;
@property (nonatomic, strong, readonly) NSNumber *goalCompletedSoFar;
@property (nonatomic, strong, readonly) NSNumber *totalGoal;

#pragma mark - Methods

- (instancetype)initWithBuilder:(BadgeBuilder *)builder;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
