//
//  DAO.m
//  Prolific
//
//  Created by meganyu on 7/16/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "DAO.h"

@import FirebaseFirestore;
@import FirebaseAuth;
#import "ProjectBuilder.h"
#import "RoundBuilder.h"
#import "SnippetBuilder.h"

#pragma mark - Constants

static NSString *const kAuthorIdKey = @"authorId";
static NSString *const kCurrentRoundKey = @"currentRound";
static NSString *const kCreatedAtKey = @"createdAt";
static NSString *const kDisplayNameKey = @"displayName";
static NSString *const kEndTimeKey = @"endTime";
static NSString *const kFollowCountKey = @"followCount";
static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kKarmaKey = @"karma";
static NSString *const kNameKey = @"name";
static NSString *const kProfileImagesRef = @"profileImages";
static NSString *const kProjectsKey = @"projects";
static NSString *const kRankKey = @"rank";
static NSString *const kRoundsKey = @"rounds";
static NSString *const kScoreKey = @"score";
static NSString *const kSeedKey = @"seed";
static NSString *const kSubmissionsKey = @"submissions";
static NSString *const kTextKey = @"text";
static NSString *const kUsersKey = @"users";
static NSString *const kUsersFollowingKey = @"usersFollowing";
static NSString *const kUserVotesKey = @"userVotes";
static NSString *const kUsernameKey = @"username";
static NSString *const kVoteCountKey = @"voteCount";
static NSString *const kVoteDataKey = @"voteData";
static NSString *const kWinningSnippetIdKey = @"winningSnippetId";


@interface DAO ()

@property (nonatomic, strong) FIRFirestore *db;
@property (nonatomic, strong) FIRStorage *storage;

@end

@implementation DAO

- (instancetype)init
{
    self = [super init];
    if (self) {
        _db = [FIRFirestore firestore];
        _storage = [FIRStorage storage];
    }
    return self;
}

#pragma mark - User

- (void)saveUser:(User *)user
      completion:(void(^)(NSString *userId, NSError *error))completion {
    
    NSDictionary *const userData = @{
        kUsernameKey: user.username,
        kDisplayNameKey: user.displayName,
        kKarmaKey: user.karma
    };
    
    [[[_db collectionWithPath:kUsersKey] documentWithPath:user.userId] setData:userData
                                                                         merge:YES
                                                                    completion:^(NSError *error) {
        error ? completion(nil, error) : completion(user.userId, nil);
    }];
}

- (void)getUserWithId:(NSString *)userId
           completion:(void(^)(User *user, NSError *error))completion {
    [[[_db collectionWithPath:kUsersKey] documentWithPath:userId] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            User *const user = [self buildUserWithId:userId fromData:snapshot.data];
            user ? completion(user, nil) : completion(nil, error);
        }
    }];
}

- (void)getAllFollowedProjectsforUserId:(NSString *)userId
                             completion:(void(^)(NSArray *projects, NSError *error))completion {
    FIRCollectionReference *const projectsRef = [self.db collectionWithPath:kProjectsKey];
    
    [[projectsRef queryWhereField:kUsersFollowingKey arrayContains:userId]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            NSMutableArray *const projs = [[NSMutableArray alloc] init];
            for (FIRDocumentSnapshot *const document in snapshot.documents) {
                Project *const proj = [self buildProjectWithId:document.documentID
                                                      fromData:document.data];
                if (proj) {
                    [projs addObject:proj];
                }
            }
            completion(projs, nil);
        }
    }];
}

#pragma mark - Snippet

- (void)submitSnippetWithBuilder:(SnippetBuilder *)snippetBuilder
                    forProjectId:(NSString *)projectId
                      forRoundId:(NSString *)roundId
                      completion:(void(^)(Snippet *snippet, NSError *error))completion {
    FIRCollectionReference *const submissionsRef =
    [[[[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
       collectionWithPath:kRoundsKey] documentWithPath:roundId]
     collectionWithPath:kSubmissionsKey];
    
    NSDictionary *const snippetData = @{
        kAuthorIdKey: snippetBuilder.authorId,
        kTextKey: snippetBuilder.text,
        kVoteCountKey: snippetBuilder.voteCount,
        kCreatedAtKey: [FIRTimestamp timestampWithDate:snippetBuilder.createdAt],
        kUserVotesKey : snippetBuilder.userVotes,
        kRankKey : snippetBuilder.rank,
        kScoreKey : snippetBuilder.score
    };
    
    __block FIRDocumentReference *ref =
    [submissionsRef addDocumentWithData:snippetData
                             completion:^(NSError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            Snippet *snippet = [[snippetBuilder withId:ref.documentID]
                                build];
            snippet ? completion(snippet, nil) : completion(nil, error);
        }
    }];
}

- (void)updateExistingSnippet:(Snippet *)snippet
                 forProjectId:(NSString *)projectId
                     forRound:(Round *)round
                   completion:(void(^)(NSError *error))completion {
    
    FIRDocumentReference *const snippetRef =
    [[[[[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
        collectionWithPath:kRoundsKey] documentWithPath:round.roundId]
      collectionWithPath:kSubmissionsKey] documentWithPath:snippet.snippetId];
    
    NSString *const currUserId = [FIRAuth auth].currentUser.uid;
    NSMutableDictionary *const snippetData = [[NSMutableDictionary alloc] init];
    
    [snippet setValue:snippet.voteCount forKey:kVoteCountKey];
    [snippet setValue:[FIRFieldValue fieldValueForArrayUnion:@[currUserId]] forKey:kUserVotesKey];
    [snippet setValue:snippet.rank forKey:kRankKey];
    [snippet setValue:snippet.score forKey:kScoreKey];
    
    if (!snippet.userVoted) {
        [snippet setValue:[FIRFieldValue fieldValueForArrayRemove:@[currUserId]] forKey:kUserVotesKey];
    }
    
    [snippetRef updateData:snippetData completion:^(NSError * _Nullable error) {
        error ? completion(error) : completion(nil);
    }];
}

- (void)getAllSubmissionsforRoundId:(NSString *)roundId
                          projectId:(NSString *)projectId
                         completion:(void(^)(NSMutableArray *submissions, NSError *error))completion {
    FIRCollectionReference *const submissionsRef =
    [[[[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
       collectionWithPath:kRoundsKey] documentWithPath:roundId]
     collectionWithPath:kSubmissionsKey];
    
    [submissionsRef getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            NSMutableArray *submissions = [[NSMutableArray alloc] init];
            for (FIRDocumentSnapshot *const document in snapshot.documents) {
                Snippet *const snippet = [self buildSnippetWithId:document.documentID
                                                         fromData:document.data];
                if (snippet) {
                    [submissions addObject:snippet];
                }
            }
            completion(submissions, nil);
        }
    }];
}

- (void)getSubmissionWithId:(NSString *)snippetId
                 forRoundId:(NSString *)roundId
                  projectId:(NSString *)projectId
                 completion:(void(^)(Snippet *snippet, NSError *error))completion {
    FIRDocumentReference *const submissionRef =
    [[[[[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
        collectionWithPath:kRoundsKey] documentWithPath:roundId]
      collectionWithPath:kSubmissionsKey] documentWithPath:snippetId];
    
    [submissionRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
        Snippet *snippet = [self buildSnippetWithId:snippetId
                                    fromData:snapshot.data];
    
        if (snippet != nil) {
            completion(snippet, nil);
        } else {
            completion(nil, error);
        }
    }];
}

#pragma mark - Rounds

- (void)saveNewRoundWithBuilder:(RoundBuilder *)roundBuilder
                   forProjectId:(NSString *)projectId
                    completion:(void(^)(Round *round,  NSError *error))completion {
    FIRCollectionReference *const roundsRef =
    [[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
       collectionWithPath:kRoundsKey];
    
    NSDictionary *const roundData = @{
        kCreatedAtKey: [FIRTimestamp timestampWithDate:roundBuilder.createdAt],
        kIsCompleteKey: [NSNumber numberWithBool:roundBuilder.isComplete],
        kEndTimeKey: [FIRTimestamp timestampWithDate:roundBuilder.endTime],
        kVoteDataKey: roundBuilder.voteData
    };
    
    __block FIRDocumentReference *ref =
    [roundsRef addDocumentWithData:roundData
                             completion:^(NSError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            Round *round = [[roundBuilder withId:ref.documentID]
                                build];
            round ? completion(round, nil) : completion(nil, error);
        }
    }];
}

- (void)updateExistingRound:(Round *)round
               forProjectId:(NSString *)projectId
                 completion:(void(^)(NSError *error))completion {
    
    FIRDocumentReference *const roundRef =
    [[[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
        collectionWithPath:kRoundsKey] documentWithPath:round.roundId];
    
    NSDictionary *const roundData = @{
        kEndTimeKey: [FIRTimestamp timestampWithDate: round.endTime],
        kIsCompleteKey: [NSNumber numberWithBool:round.isComplete],
        kVoteDataKey: round.voteData,
        kWinningSnippetIdKey: round.winningSnippetId
    };
    
    [roundRef updateData:roundData completion:^(NSError * _Nullable error) {
        error ? completion(error) : completion(nil);
    }];
}

- (void)getAllRoundsForProjectId:(NSString *)projectId
                      completion:(void(^)(NSMutableArray *rounds, NSError *error))completion {
    FIRCollectionReference *const roundsRef =
    [[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId]
     collectionWithPath:kRoundsKey];
    
    [[roundsRef queryOrderedByField:kCreatedAtKey] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            NSMutableArray *const rounds = [[NSMutableArray alloc] init];
            for (FIRDocumentSnapshot *document in snapshot.documents) {
                Round *const round = [self buildRoundWithId:document.documentID
                                                   fromData:document.data];
                if (round) {
                    [rounds addObject:round];
                }
            }
            completion(rounds, nil);
        }
    }];
}

/** Retrieves Firebase document reference for the latest Round in a Project with ProjectId and passes into completion block. Passes an error into completion block if no relevant document is found. */
- (void)getLatestRoundRefForProjectId:(NSString *)projectId
                        completion:(void(^)(FIRDocumentReference *roundRef, NSError *error))completion {
    FIRCollectionReference *const roundsRef =
       [[[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId] collectionWithPath:kRoundsKey];
    
    [[[roundsRef queryOrderedByField:kCreatedAtKey descending:YES] queryLimitedTo:1]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (snapshot.documents.firstObject.exists) {
            NSString *const roundId = snapshot.documents.firstObject.documentID;
            FIRDocumentReference *const roundRef = [roundsRef documentWithPath:roundId];
            completion(roundRef, nil);
        } else {
            completion(nil, error);
        }
    }];
}

#pragma mark - Projects

- (void)updateFollowersforProject:(Project *)project
                       withUserId:(NSString *)userId
                       completion:(void(^)(NSError *error))completion {    
    FIRDocumentReference *const projRef = [[self.db collectionWithPath:kProjectsKey] documentWithPath:project.projectId];
    
    NSMutableDictionary *const projData = [[NSMutableDictionary alloc] init];
    [projData setValue:project.followCount forKey:kFollowCountKey];
    [projData setValue:[FIRFieldValue fieldValueForArrayUnion:@[userId]] forKey:kUsersFollowingKey];
    
    if (!project.userFollowed) {
        [projData setValue:[FIRFieldValue fieldValueForArrayRemove:@[userId]] forKey:kUsersFollowingKey];
    }
    
    [projRef updateData:projData completion:^(NSError *error) {
        error ? completion(error) : completion(nil);
    }];
}

- (void)getAllProjectsWithCompletion:(void(^)(NSArray *projects, NSError *error))completion {
    FIRCollectionReference *const projectsRef = [self.db collectionWithPath:kProjectsKey];
    
    [[projectsRef queryOrderedByField:kCreatedAtKey]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            NSMutableArray *const projs = [[NSMutableArray alloc] init];
            for (FIRDocumentSnapshot *const document in snapshot.documents) {
                Project *const proj = [self buildProjectWithId:document.documentID
                                                      fromData:document.data];
                if (proj) {
                    [projs addObject:proj];
                }
            }
            completion(projs, nil);
        }
    }];
}

- (void)getProjectWithId:(NSString *)projectId
              completion:(void(^)(Project *project, NSError *error))completion {
    FIRDocumentReference *const projRef =
    [[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId];
    [projRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
        Project *proj = [self buildProjectWithId:projectId
                                        fromData:snapshot.data];
        
        if (proj != nil) {
            completion(proj, nil);
        } else {
            completion(nil, error);
        }
    }];
}

#pragma mark - Cloud Storage

- (FIRStorageUploadTask *)uploadProfileImage:(NSData *)imageData
                                     forUser:(User *)user
                                  completion:(void(^)(NSURL *downloadURL, NSError *error))completion {
    NSString *const currUserId = user.userId;
    
    FIRStorageReference *const storageRef = [_storage reference];
    FIRStorageReference *const profileImagesRef = [storageRef child:kProfileImagesRef];
    FIRStorageReference *const profileImageRef = [profileImagesRef child:[NSString stringWithFormat:@"%@.png", currUserId]];
    
    FIRStorageMetadata *const uploadMetadata = [[FIRStorageMetadata alloc] init];
    uploadMetadata.contentType = @"image/png";
    
    FIRStorageUploadTask *const uploadTask = [profileImageRef putData:imageData
                                                             metadata:uploadMetadata
                                                           completion:^(FIRStorageMetadata *metadata,
                                                                        NSError *error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            [profileImageRef downloadURLWithCompletion:^(NSURL *URL, NSError *error) {
                if (error != nil) {
                    completion(nil, error);
                } else {
                    NSURL *downloadURL = URL;
                    completion(downloadURL, nil);
                }
            }];
        }
    }];
    
    return uploadTask;
}

- (void)getProfileImageforUser:(User *)user
                    completion:(void(^)(UIImage *userImage, NSError *error))completion {
    NSString *const userId = user.userId;
    
    FIRStorageReference *const storageRef = [_storage reference];
    FIRStorageReference *const profileImagesRef = [storageRef child:kProfileImagesRef];
    FIRStorageReference *const profileImageRef = [profileImagesRef child:[NSString stringWithFormat:@"%@.png", userId]];
    
    [profileImageRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            UIImage *userImage = [UIImage imageWithData:data];
            completion(userImage, nil);
        }
    }];
}


#pragma mark - Helper functions

- (User *)buildUserWithId:(NSString *)userId
                   fromData:(NSDictionary *)data {
    UserBuilder *const userBuilder = [[UserBuilder alloc] initWithId:userId
                                                          dictionary:data];
    User *const user = [userBuilder build];
    
    if (user != nil) {
        return user;
    } else {
        return nil;
    }
}

- (Snippet *)buildSnippetWithId:(NSString *)snippetId
                   fromData:(NSDictionary *)data {
    SnippetBuilder *const snippetBuilder = [[SnippetBuilder alloc] initWithId:snippetId
                                                                   dictionary:data];
    Snippet *const snippet = [snippetBuilder build];
    
    if (snippet != nil) {
        return snippet;
    } else {
        return nil;
    }
}

- (Round *)buildRoundWithId:(NSString *)roundId
                   fromData:(NSDictionary *)data {
    NSMutableArray *const submissions = [[NSMutableArray alloc] init];
    
    RoundBuilder *const roundBuilder = [[RoundBuilder alloc] initWithId:roundId
                                                             dictionary:data
                                                            submissions:submissions];
    Round *const round = [roundBuilder build];
    
    if (round != nil) {
        return round;
    } else {
        return nil;
    }
}

- (Project *)buildProjectWithId:(NSString *)projectId
                       fromData:(NSDictionary *)data {
    NSMutableArray *const rounds = [[NSMutableArray alloc] init];
    
    ProjectBuilder *const projbuilder = [[ProjectBuilder alloc] initWithId:projectId
                                                                dictionary:data
                                                                    rounds:rounds];
    Project *const proj = [projbuilder build];
    if (proj != nil) {
        return proj;
    } else {
        return nil;
    }
}

@end
