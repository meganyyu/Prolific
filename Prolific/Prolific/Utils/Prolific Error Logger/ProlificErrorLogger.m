//
//  ProlificErrorLogger.m
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificErrorLogger.h"

#import "ProlificUtils.h"

@implementation ProlificErrorLogger

+ (void)logErrorWithMessage:(NSString *)message
           shouldRaiseAlert:(BOOL)shouldRaiseAlert {
    ProlificError *const error = [[ProlificError alloc] initWithMessage:message];
    NSLog(@"ERROR: %@", [error description]);
    if (shouldRaiseAlert) {
        // FIXME: Create a reusable raiseAlertWithMessage function in ProlificUtils
    }
}

@end

@implementation ProlificError

- (instancetype)initWithMessage:(NSString *)message {
    self = [super init];
    if (self) {
        _message = message;
        _time = [NSDate date];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Prolific Error. Message: %@ \nTime: %@", _message, _time];
}

@end
