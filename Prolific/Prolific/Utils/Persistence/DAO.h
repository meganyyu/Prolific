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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DAO : NSObject

#pragma mark - User

/** Save a user's data to database. */
- (void)saveUser:(User *)user
      completion:(void(^)(NSString *userId, NSError *error))completion;

/** Gets user with userId. */
- (void)getUserWithId:(NSString *)userId
           completion:(void(^)(User *user, NSError *error))completion;

/** Follows a project for a user on server side. */
- (void)followProject:(Project *)project
              forUser:(User *)user
           completion:(void(^)(NSError *error))completion;

/** Unfollows a project for a user on server side. */
- (void)unfollowProject:(Project *)project
                forUser:(User *)user
             completion:(void(^)(NSError *error))completion;

#pragma mark - Snippet

/** Submits a snippet to the latest round of a project with the identifier projectId. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)submitSnippetWithBuilder:(SnippetBuilder *)snippetBuilder
                    forProjectId:(NSString *)projectId
                      forRoundId:(NSString *)roundId
                      completion:(void(^)(Snippet *snippet, NSError *error))completion;

/** Updates a snippet for a round in a project with the identifier projectId. Will return error message if update unsuccessful. */
- (void)updateExistingSnippet:(Snippet *)snippet forProjectId:(NSString *)projectId forRound:(Round *)round completion:(void(^)(NSError *error))completion;

/** Gets all submissions from latest round of a project with the identifier projectId. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)getAllSubmissionsforRoundId:(NSString *)roundId
                          projectId:(NSString *)projectId
                         completion:(void(^)(NSMutableArray *submissions, NSError *error))completion;

/** Gets submissions with the identifier snippetId from a specified round and project. Will return error message if snippet document does not exist. */
- (void)getSubmissionWithId:(NSString *)snippetId
                 forRoundId:(NSString *)roundId
                  projectId:(NSString *)projectId
                 completion:(void(^)(Snippet *snippet, NSError *error))completion;

#pragma mark - Round

/** Saves a new round to a project with identifier projectId. Will return error message if project document does not have any rounds as expected. */
- (void)saveNewRoundWithBuilder:(RoundBuilder *)roundBuilder
                     forProjectId:(NSString *)projectId
                     completion:(void(^)(Round *round, NSError *error))completion;

/** Updates a round in a project with the identifier projectId. Will return error message if update unsuccessful. */
- (void)updateExistingRound:(Round *)round
               forProjectId:(NSString *)projectId
                 completion:(void(^)(NSError *error))completion;

/** Gets all rounds from a project with the identifier projectId, in order from earliest to latest. This is a shallow level retrieval - will not retrieve all submissions for a round. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)getAllRoundsForProjectId:(NSString *)projectId
                      completion:(void(^)(NSMutableArray *rounds, NSError *error))completion;

#pragma mark - Project

/** Gets all projects in order from latest to earliest. This is a shallow level retrieval - will not retrieve all rounds for a project. Will return error message if unable to retrieve projects. */
- (void)getAllProjectsWithCompletion:(void(^)(NSArray *projects, NSError *error))completion;

/** Gets a specific project with projectId. Will return error message if unable to retrieve specific project. */
- (void)getProjectWithId:(NSString *)projectId
              completion:(void(^)(Project *project, NSError *error))completion;

#pragma mark - Firebase Storage

/** Uploads a profile image under a user's id to server. */
- (FIRStorageUploadTask *)uploadProfileImage:(NSData *)imageData
                                     forUser:(User *)user
                                  completion:(void(^)(NSURL *downloadURL, NSError *error))completion;

/** Retrieves a profile image for a user from server. */
- (void)getProfileImageforUser:(User *)user
                    completion:(void(^)(UIImage *userImage, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
