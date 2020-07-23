//
//  ProlificUtils.m
//  Prolific
//
//  Created by meganyu on 7/22/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificUtils.h"

@implementation ProlificUtils

+ (BOOL)isBoolNumber:(NSNumber *)num {
   CFTypeID boolID = CFBooleanGetTypeID(); // the type ID of CFBoolean
   CFTypeID numID = CFGetTypeID((__bridge CFTypeRef)(num)); // the type ID of passed in num
   return numID == boolID;
}

+ (NSDate *)convertTimestampToDate:(FIRTimestamp *)timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp seconds]];
    return date;
}

@end
