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

/** Updates a project's latest round or adds any new rounds as necessary. If successful, passes project back through completion block. Else passes back nil project and error. */
+ (void)updateProject:(Project *)project
           completion:(void(^)(Project *project, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
