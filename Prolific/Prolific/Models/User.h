//
//  User.h
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

+ (void)createUserWithUserId:(NSString *)userId withUsername:(NSString *)username;

@end

NS_ASSUME_NONNULL_END
