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
static NSString *const kNameKey = @"name";
static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kProjectsKey = @"projects";
static NSString *const kRoundsKey = @"rounds";
static NSString *const kSeedKey = @"seed";
static NSString *const kSubmissionsKey = @"submissions";
static NSString *const kTextKey = @"text";
static NSString *const kUsersKey = @"users";
static NSString *const kUserVotesKey = @"userVotes";
static NSString *const kUsernameKey = @"username";
static NSString *const kVoteCountKey = @"voteCount";
static NSString *const kWinningSnippetKey = @"winningSnippet";

@interface DAO ()

@property (nonatomic, strong) FIRFirestore *db;

@end

@implementation DAO

- (instancetype)init
{
    self = [super init];
    if (self) {
        _db = [FIRFirestore firestore];
    }
    return self;
}

#pragma mark - User

- (void)saveUser:(User *)user
      completion:(void(^)(NSString *userId, NSError *error))completion {
    
    NSDictionary *const userData = @{
        kUsernameKey: user.username,
        kDisplayNameKey: user.displayName
    };
    
    [[[_db collectionWithPath:kUsersKey] documentWithPath:user.userId] setData:userData
                                                                       merge:YES
                                                                  completion:^(NSError * _Nullable error) {
        error ? completion(nil, error) : completion(user.userId, nil);
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
        kUserVotesKey : [[NSArray alloc] init]
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
    NSDictionary *snippetData;
    
    if (snippet.userVoted) {
        snippetData = @{
            kVoteCountKey: snippet.voteCount,
            kUserVotesKey: [FIRFieldValue fieldValueForArrayUnion:@[currUserId]]
        };
    } else {
        snippetData = @{
            kVoteCountKey: snippet.voteCount,
            kUserVotesKey: [FIRFieldValue fieldValueForArrayRemove:@[currUserId]]
        };
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

// TODO: write a function that retrieves a specific snippet with snippetId from round with roundId

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
        kEndTimeKey: [FIRTimestamp timestampWithDate:roundBuilder.endTime]
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
    
    NSDictionary *roundData;
    
    if (round.winningSnippetId) {
        roundData = @{
            kEndTimeKey: [FIRTimestamp timestampWithDate: round.endTime],
            kIsCompleteKey: [NSNumber numberWithBool:round.isComplete],
            kWinningSnippetKey: round.winningSnippetId
        };
    } else {
        roundData = @{
            kEndTimeKey: [FIRTimestamp timestampWithDate: round.endTime],
            kIsCompleteKey: [NSNumber numberWithBool:round.isComplete]
        };
    }
    
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
            NSMutableArray *rounds = [[NSMutableArray alloc] init];
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

// TODO: modify this function to retrieve a full project with rounds
- (void)getProjectWithId:(NSString *)projectId
    completion:(void(^)(Project *project, NSError *error))completion {
    FIRDocumentReference *projRef =
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

#pragma mark - Helper functions

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
    //FIXME: fill array with submissions from Firebase
    
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
    //FIXME: fill array with rounds from Firebase
    
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
