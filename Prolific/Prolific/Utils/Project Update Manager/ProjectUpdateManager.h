//
//  ProjectUpdateManager.h
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project.h"
#import "ProjectBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectUpdateManager : NSObject

+ (void)updateProject:(Project *)project
           completion:(void(^)(Project *project, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
