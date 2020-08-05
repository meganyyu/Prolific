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
@property (nonatomic, strong) NSNumber *goalCompleted;
@property (nonatomic, strong) NSNumber *totalGoal;

@end

NS_ASSUME_NONNULL_END
