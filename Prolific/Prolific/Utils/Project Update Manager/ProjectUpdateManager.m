//
//  ProjectUpdateManager.m
//  Prolific
//
//  Created by meganyu on 7/24/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectUpdateManager.h"

#import "DAO.h"

@implementation ProjectUpdateManager

+ (void)updateProject:(Project *)project
           completion:(void(^)(Project *project, NSError *error))completion {
    DAO *const dao = [[DAO alloc] init];
    
    // Populate project model with all the rounds for the project fetched from server
    [dao getAllRoundsForProjectId:project.projectId
                       completion:^(NSMutableArray *rounds, NSError *error) {
        if (rounds) {
            // If successfully retrieved rounds, then populate the latest round with all of its submissions
            Round *const latestRound = rounds[rounds.count - 1];
            
            [dao getAllSubmissionsforRoundId:latestRound.roundId
                                   projectId:project.projectId
                                  completion:^(NSMutableArray *submissions, NSError *error) {
                if (submissions) {
                    // If fetching submissions was successful, then check whether the latest round should be completed, extended, or left alone
                    RoundBuilder *const roundBuilder = [[[RoundBuilder alloc] initWithRound:latestRound]
                                                        withSubmissions:submissions];
                    RoundBuilder *const roundBuilderMarkedComplete = [roundBuilder markCompleteAndSetWinningSnippet];
                    RoundBuilder *const roundBuilderExtendedTime = [roundBuilder extendEndTime];
                    
                    if (roundBuilderMarkedComplete) {
                        // If the round should be marked as complete, update the latest round on both server/client and...
                        Round *const updatedLatestRound = [roundBuilder build];
                        
                        [dao updateExistingRound:updatedLatestRound
                                         forProjectId:project.projectId
                                           completion:^(NSError * _Nonnull error) {
                            if (error) {
                                completion(nil, error);
                            } else {
                                // ...start a new round if updating the latest round was successful!
                                RoundBuilder *const newRoundBuilder = [[RoundBuilder alloc] init];
                                [dao saveNewRoundWithBuilder:newRoundBuilder
                                                forProjectId:project.projectId
                                                  completion:^(Round *round, NSError *error) {
                                    if (round) {
                                        // And then compile a project with the updated latest round and the new round
                                        Project *const updatedProj = [[[[[[ProjectBuilder alloc] initWithProject:project]
                                                                   withRounds:rounds]
                                                                  updateLatestRound:updatedLatestRound]
                                                                 addRound:round]
                                                                build];
                                        updatedProj ? completion(updatedProj, nil) : completion(nil, error);
                                    } else {
                                        completion(nil, error);
                                    }
                                }];
                            }
                        }];
                    } else if (roundBuilderExtendedTime) {
                        // If the round should be extended instead, then update the latest round on both server/client
                        Round *const extendedLatestRound = [roundBuilder build];
                        
                        [dao updateExistingRound:extendedLatestRound
                                         forProjectId:project.projectId
                                           completion:^(NSError *error) {
                            if (error) {
                                completion(nil, error);
                            } else {
                                // compile a project wiht the updated latest round
                                Project *const updatedProj = [[[[[ProjectBuilder alloc] initWithProject:project]
                                                          withRounds:rounds]
                                                         updateLatestRound:extendedLatestRound]
                                                        build];
                                updatedProj ? completion(updatedProj, nil) : completion(nil, error);
                            }
                        }];
                    }
                } else {
                    // If fetching latest round's submissions was unsuccessful, just return the project with its rounds for now
                    Project *const projWithRounds = [[[[ProjectBuilder alloc] initWithProject:project]
                                                   withRounds:rounds]
                                                   build];
                    projWithRounds ? completion(projWithRounds, nil) : completion(nil, error);
                }
            }];
        } else {
            completion(nil, error);
        }
    }];
}

@end
