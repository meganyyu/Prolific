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
    
    [dao getAllRoundsForProjectId:project.projectId
                       completion:^(NSMutableArray *rounds, NSError *error) {
        if (rounds) {
            Round *const latestRound = rounds[rounds.count - 1];
            
            [dao getAllSubmissionsforRoundId:latestRound.roundId
                                   projectId:project.projectId
                                  completion:^(NSMutableArray *submissions, NSError *error) {
                if (submissions) {
                    RoundBuilder *const roundBuilder = [[[RoundBuilder alloc] initWithRound:latestRound]
                                                        withSubmissions:submissions];
                    RoundBuilder *const roundBuilderMarkedComplete = [roundBuilder markCompleteAndSetWinningSnippet];
                    RoundBuilder *const roundBuilderExtendedTime = [roundBuilder extendEndTime];
                    
                    if (roundBuilderMarkedComplete) {
                        Round *const updatedLatestRound = [roundBuilder build];
                        
                        [dao updateExistingRound:updatedLatestRound
                                         forProjectId:project.projectId
                                           completion:^(NSError * _Nonnull error) {
                            if (error) {
                                completion(nil, error);
                            } else {
                                RoundBuilder *const newRoundBuilder = [[RoundBuilder alloc] init];
                                [dao saveNewRoundWithBuilder:newRoundBuilder
                                                forProjectId:project.projectId
                                                  completion:^(Round *round, NSError *error) {
                                    if (round) {
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
                        Round *const extendedLatestRound = [roundBuilder build];
                        
                        [dao updateExistingRound:extendedLatestRound
                                         forProjectId:project.projectId
                                           completion:^(NSError *error) {
                            if (error) {
                                completion(nil, error);
                            } else {
                                Project *const updatedProj = [[[[[ProjectBuilder alloc] initWithProject:project]
                                                          withRounds:rounds]
                                                         updateLatestRound:extendedLatestRound]
                                                        build];
                                updatedProj ? completion(updatedProj, nil) : completion(nil, error);
                            }
                        }];
                    }
                } else {
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
