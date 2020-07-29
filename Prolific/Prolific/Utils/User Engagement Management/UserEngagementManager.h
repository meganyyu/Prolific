//
//  UserEngagementManager.h
//  Prolific
//
//  Created by meganyu on 7/29/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project.h"
#import "Round.h"
#import "Snippet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserEngagementManager : NSObject

+ (NSArray *)rankSubmissionsForRound:(Round *)round;

+ (NSDictionary *)scoreSubmissionsForRound:(Round *)round;

+ (NSDecimalNumber *)calculateScoreForSubmission:(Snippet *)snippet;

@end

NS_ASSUME_NONNULL_END
