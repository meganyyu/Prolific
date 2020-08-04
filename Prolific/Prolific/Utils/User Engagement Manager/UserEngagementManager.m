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

+ (NSDecimalNumber *)computeKarmaValueForUserEngagementType:(UserEngagementType)userEngagementType {
    switch (userEngagementType) {
        case UserEngagementTypeViewProject:
        case UserEngagementTypeViewRound:
            return [NSDecimalNumber decimalNumberWithString:@"0.01"];
            break;
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
