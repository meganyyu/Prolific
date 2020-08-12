//
//  BadgeFeedCell.h
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FeedCell.h"

#import "Badge.h"

NS_ASSUME_NONNULL_BEGIN

@interface BadgeFeedCell : FeedCell

@property (nonatomic, strong) NSArray<Badge *> *badges;

@end

NS_ASSUME_NONNULL_END
