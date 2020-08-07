//
//  ProlificErrorLogger.h
//  Prolific
//
//  Created by meganyu on 8/5/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ProlificErrorLogger class

@interface ProlificErrorLogger : NSObject

+ (void)logErrorWithMessage:(NSString *)message
           shouldRaiseAlert:(BOOL)shouldRaiseAlert;

@end

#pragma mark - ProlificError class

@interface ProlificError : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *time;

- (instancetype)initWithMessage:(NSString *)message;

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END
