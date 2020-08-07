//
//  UserEngagementManager.m
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "UserEngagementManager.h"

#import "Badge.h"
#import "BadgeBuilder.h"
#import "UserBuilder.h"

#pragma mark - Badge Types

static NSString *const kContributorBadgeId = @"contributor-badge";
static NSString *const kBigHitWriterBadgeId = @"big-hit-writer-badge";
static NSString *const kCreatorBadgeId = @"creator-badge";

#pragma mark - Implementation

@implementation UserEngagementManager

+ (User *)updateKarmaAndBadgesForUser:(User *)user
                        forEngagement:(UserEngagementType)userEngagementType {
    NSDecimalNumber *const newKarma = [UserEngagementManager computeKarmaValueForUserEngagementType:userEngagementType];
    UserBuilder *userBuilder = [[[UserBuilder alloc] initWithUser:user]
                                      addKarma:newKarma];
    userBuilder = [self updateBadgesForUserBuilder:userBuilder userEngagementType:userEngagementType];
    
    User *const updatedUser = [userBuilder build];
    
    if (updatedUser) {
        return updatedUser;
    }
    return user;
}

#pragma mark - Helper Functions

+ (NSDecimalNumber *)computeKarmaValueForUserEngagementType:(UserEngagementType)userEngagementType {
    switch (userEngagementType) {
        case UserEngagementTypeSubmitSnippet:
            return [NSDecimalNumber decimalNumberWithString:@"0.1"];
            break;
        case UserEngagementTypeVote:
            return [NSDecimalNumber decimalNumberWithString:@"0.1"];
            break;
        case UserEngagementTypeComposeProject:
            return [NSDecimalNumber decimalNumberWithString:@"3"];
            break;
        case UserEngagementTypeWinRound:
            return [NSDecimalNumber decimalNumberWithString:@"5.0"];
            break;
        case UserEngagementTypeCompleteBadge:
            return [NSDecimalNumber decimalNumberWithString:@"10.0"];
            break;
    }
}

+ (UserBuilder *)updateBadgesForUserBuilder:(UserBuilder *)userBuilder userEngagementType:(UserEngagementType)userEngagementType {
    switch (userEngagementType) {
        case UserEngagementTypeSubmitSnippet: {
            Badge *const updatedBadge = [[[[BadgeBuilder alloc] initWithBadge:[userBuilder.badges valueForKey:kContributorBadgeId]]
                                          addToGoal:1]
                                         build];
            return [userBuilder updateExistingBadge:updatedBadge];
            break;
        }
        case UserEngagementTypeComposeProject: {
            Badge *const updatedBadge = [[[[BadgeBuilder alloc] initWithBadge:[userBuilder.badges valueForKey:kCreatorBadgeId]]
                                          addToGoal:1]
                                         build];
            return [userBuilder updateExistingBadge:updatedBadge];
            break;
        }
        case UserEngagementTypeWinRound: {
            Badge *const updatedBadge = [[[[BadgeBuilder alloc] initWithBadge:[userBuilder.badges valueForKey:kBigHitWriterBadgeId]]
                                          addToGoal:1]
                                         build];
            return [userBuilder updateExistingBadge:updatedBadge];
            break;
        }
        case UserEngagementTypeVote:
        case UserEngagementTypeCompleteBadge:
            break;
    }
    
    return userBuilder;
}

@end
