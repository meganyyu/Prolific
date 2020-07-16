//
//  DAO.h
//  Prolific
//
//  Created by meganyu on 7/16/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DAO : NSObject

- (void)saveUser:(User *)user;

- (void)getAllProjectsWithCompletion:(void(^)(NSArray *projects, NSError *error))completion;

- (void)getProjectWithId:(NSString *)projectId
              completion:(void(^)(Project *project, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
