//
//  DAO.h
//  Prolific
//
//  Created by meganyu on 7/16/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project.h"
#import "Round.h"
#import "Snippet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DAO : NSObject

- (void)saveUser:(User *)user
      completion:(void(^)(NSString *userId, NSError *error))completion;

/** Submits a snippet to the latest round of a project with the identifier projectId. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)submitSnippetWithBuilder:(SnippetBuilder *)snippetBuilder
                    forProjectId:(NSString *)projectId
                      completion:(void(^)(Snippet *snippet, NSError *error))completion;

/** Gets all submissions from latest round of a project with the identifier projectId. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)getLatestSubmissionsforProjectId:(NSString *)projectId
                              completion:(void(^)(NSMutableArray *submissions, NSError *error))completion;

- (void)getAllProjectsWithCompletion:(void(^)(NSArray *projects, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
