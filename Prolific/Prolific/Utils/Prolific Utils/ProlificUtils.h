//
//  ProlificUtils.h
//  Prolific
//
//  Created by meganyu on 7/22/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface ProlificUtils : NSObject

/** Checks whether an NSNumber is a boolean. */
+ (BOOL)isBoolNumber:(NSNumber *)num;

/** Converts a FirTimestamp to an NSDate. */
+ (NSDate *)convertTimestampToDate:(FIRTimestamp *)timestamp;

@end

NS_ASSUME_NONNULL_END
