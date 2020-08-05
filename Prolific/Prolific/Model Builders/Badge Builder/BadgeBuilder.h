//
//  BadgeBuilder.h
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Badge;

#import "Entity.h"

#import "Badge.h"

NS_ASSUME_NONNULL_BEGIN

@interface BadgeBuilder : EntityBuilder

#pragma mark - Properties

// required (and immutable) attributes
@property (nonatomic, strong) NSString *badgeType;

// required (and mutable) attributes
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSNumber *goalCompletedSoFar;
@property (nonatomic, strong) NSNumber *totalGoal;

#pragma mark - Methods

/** Returns BadgeBuilder with all fields initialized based on badge type. If invalid badge type is entered, returns nil. */
- (instancetype)initWithType:(NSString *)badgeType;

/** Returns BadgeBuilder with all fields initialized based on dictionary data, unless data is missing values, in which case it initializes a BadgeBuilder the same way as init does. */
- (instancetype)initWithType:(NSString *)badgeType dictionary:(NSDictionary *)data;

/** Returns BadgeBuilder with all fields initialized as a copy of a Badge model. */
- (instancetype)initWithBadge:(Badge *)badge;

- (BadgeBuilder *)withType:(NSString *)badgeType;

- (BadgeBuilder *)withLevel:(NSNumber *)level;

- (BadgeBuilder *)withGoalCompletedSoFar:(NSNumber *)goalCompletedSoFar;

- (BadgeBuilder *)addToGoal:(NSInteger)amount;

- (BadgeBuilder *)withTotalGoal:(NSNumber *)totalGoal;

/** Returns fully built Badge if BadgeBuilder has all fields initialized properly. Else returns nil. */
- (Badge *)build;

@end

NS_ASSUME_NONNULL_END
