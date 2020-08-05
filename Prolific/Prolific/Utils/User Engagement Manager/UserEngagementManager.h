//
//  UserEngagementManager.h
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserEngagementManager : NSObject

typedef NS_ENUM(NSInteger, UserEngagementType) {
    UserEngagementTypeSubmitSnippet,
    UserEngagementTypeVote,
    UserEngagementTypeComposeProject,
    UserEngagementTypeWinRound,
    UserEngagementTypeCompleteBadge
};

+ (User *)updateKarmaForUser:(User *)user
               forEngagement:(UserEngagementType)userEngagementType;

+ (NSDecimalNumber *)computeKarmaValueForUserEngagementType:(UserEngagementType)userEngagementType;

@end

NS_ASSUME_NONNULL_END
