//
//  UserEngagementManager.m
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "UserEngagementManager.h"

#import "UserBuilder.h"

@implementation UserEngagementManager

+ (User *)updateKarmaForUser:(User *)user
               forEngagement:(UserEngagementType)userEngagementType {
    NSDecimalNumber *const newKarma = [UserEngagementManager computeKarmaValueForUserEngagementType:userEngagementType];
    User *const updatedUser = [[[[UserBuilder alloc] initWithUser:user]
                                addKarma:newKarma]
                               build];
    
    if (updatedUser) {
        return updatedUser;
    }
    return user;
}

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

@end
