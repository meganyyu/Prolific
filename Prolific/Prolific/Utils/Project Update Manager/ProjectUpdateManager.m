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
            // Populate the latest round with all of its submissions
            Round *const latestRound = rounds[rounds.count - 1];
            
            [dao getAllSubmissionsforRoundId:latestRound.roundId
                                   projectId:project.projectId
                                  completion:^(NSMutableArray *submissions, NSError *error) {
                if (submissions) {
                    // Check whether the latest round should be completed, extended, or left alone, and update project accordingly
                    
                    [ProjectUpdateManager updateLatestRound:latestRound
                                            withSubmissions:submissions
                                               forProjectId:project.projectId
                                                 completion:^(Round *updatedRound, Round *newRound, NSError *error) {
                        ProjectBuilder *updatedProjBuilder = [[[ProjectBuilder alloc] initWithProject:project]
                                                              withRounds:rounds];
                        if (error) {
                            completion(nil, error);
                        }
                        else {
                            updatedProjBuilder = [updatedProjBuilder updateLatestRound:updatedRound];
                            if (newRound) {
                                updatedProjBuilder = [updatedProjBuilder addRound:newRound];
                            }
                            Project *const updatedProj = [updatedProjBuilder build];
                            updatedProj ? completion(updatedProj, nil) : completion(nil, error);
                        }
                    }];
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

+ (void)updateLatestRound:(Round *)latestRound
          withSubmissions:(NSMutableArray *)submissions
             forProjectId:(NSString *)projId
               completion:(void(^)(Round *updatedRound, Round *newRound, NSError *error))completion {
    DAO *const dao = [[DAO alloc] init];
    
    RoundBuilder *const roundBuilder = [[[RoundBuilder alloc] initWithRound:latestRound]
                                        withSubmissions:submissions];
    RoundBuilder *const roundBuilderMarkedComplete = [roundBuilder markCompleteAndSetWinningSnippet];
    RoundBuilder *const roundBuilderExtendedTime = [roundBuilder extendEndTime];
    
    if (roundBuilderMarkedComplete) {
        // If the round should be marked as complete, update the latest round on both server/client and...
        Round *const updatedLatestRound = [roundBuilder build];
        
        [dao updateExistingRound:updatedLatestRound
                    forProjectId:projId
                      completion:^(NSError *error) {
            if (error) {
                completion(nil, nil, error);
            } else {
                // ...start a new round.
                RoundBuilder *const newRoundBuilder = [[RoundBuilder alloc] init];
                [dao saveNewRoundWithBuilder:newRoundBuilder
                                forProjectId:projId
                                  completion:^(Round *newRound, NSError *error) {
                    if (newRound) {
                        completion(updatedLatestRound, newRound, nil);
                    } else {
                        completion(nil, nil, error);
                    }
                }];
            }
        }];
    } else if (roundBuilderExtendedTime) {
        // If the round should be extended instead, update the latest round on both server/client
        Round *const extendedLatestRound = [roundBuilder build];
        
        [dao updateExistingRound:extendedLatestRound
                    forProjectId:projId
                      completion:^(NSError *error) {
            if (error) {
                completion(nil, nil, error);
            } else {
                completion(extendedLatestRound, nil, nil);
            }
        }];
    }
    
    // if no updates need to be made and no error, just pass back latest round with submissions
    Round *const populatedLatestRound = [roundBuilder build];
    completion(populatedLatestRound, nil, nil);
}

@end
