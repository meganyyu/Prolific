//
//  DAO.m
//  Prolific
//
//  Created by meganyu on 7/16/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "DAO.h"

@import FirebaseFirestore;
#import "ProjectBuilder.h"
#import "RoundBuilder.h"
#import "SnippetBuilder.h"

#pragma mark - Constants

static NSString *const kAuthorIdKey = @"authorId";
static NSString *const kCurrentRoundKey = @"currentRound";
static NSString *const kCreatedAtKey = @"createdAt";
static NSString *const kDisplayNameKey = @"displayName";
static NSString *const kNameKey = @"name";
static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kProjectsKey = @"projects";
static NSString *const kRoundsKey = @"rounds";
static NSString *const kSeedKey = @"seed";
static NSString *const kSubmissionsKey = @"submissions";
static NSString *const kTextKey = @"text";
static NSString *const kUsersKey = @"users";
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
        if (error != nil) {
            completion(nil, error);
        } else {
            completion(user.userId, nil);
        }
    }];
}

#pragma mark - Snippet

/** Submits a snippet to the latest round of a project with the identifier projectId. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)submitSnippetWithBuilder:(SnippetBuilder *)snippetBuilder
                    forProjectId:(NSString *)projectId
                      completion:(void(^)(Snippet *snippet, NSError *error))completion {
    
    [self getLatestRoundRefForProjectId:projectId
                             completion:^(FIRDocumentReference *roundRef, NSError *error) {
        if (roundRef) {
            NSDictionary *const snippetData = @{
                kAuthorIdKey: snippetBuilder.authorId,
                kTextKey: snippetBuilder.text,
                kVoteCountKey: snippetBuilder.voteCount
            };
            
            __block FIRDocumentReference *ref =
            [[roundRef collectionWithPath:kSubmissionsKey] addDocumentWithData:snippetData
                                                             completion:^(NSError * _Nullable error) {
                if (error != nil) {
                    completion(nil, error);
                } else {
                    NSDate *date = [NSDate date]; //FIXME: use Firebase's server time instead
                    Snippet *snippet = [[[snippetBuilder withId:ref.documentID]
                      withCreatedAtDate:date]
                     build];
                    
                    completion(snippet, nil);
                }
            }];
        } else {
            completion(nil, error);
        }
    }];
}

/** Gets all submissions from latest round of a project with the identifier projectId. Will return error message if passed in projectId is invalid or project document does not have any rounds as expected. */
- (void)getLatestSubmissionsforProjectId:(NSString *)projectId
                  completion:(void(^)(NSMutableArray *submissions, NSError *error))completion {
    [self getLatestRoundRefForProjectId:projectId
                             completion:^(FIRDocumentReference *roundRef, NSError *error) {
        if (roundRef) {
            [[roundRef collectionWithPath:kSubmissionsKey] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
                if (error != nil) {
                    completion(nil, error);
                } else {
                    NSMutableArray *submissions = [[NSMutableArray alloc] init];
                    for (FIRDocumentSnapshot *document in snapshot.documents) {
                        Snippet *const snippet = [self buildSnippetWithId:document.documentID
                                                                 fromData:document.data];
                        [submissions addObject:snippet];
                    }
                    completion(submissions, nil);
                }
            }];
        }
    }];
}

#pragma mark - Rounds

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
    [[self.db collectionWithPath:kProjectsKey]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            NSMutableArray *const projs = [[NSMutableArray alloc] init];
            
            for (FIRDocumentSnapshot *document in snapshot.documents) {
                NSLog(@"%@ => %@", document.documentID, document.data);
                
                Project *const proj = [self buildProjectWithId:document.documentID
                                                      fromData:document.data];
                
                if (proj) {
                    [projs addObject:proj];
                } else {
                    NSLog(@"Data invalid, can't build project with id %@, skipping for now.", document.documentID);
                }
            }
            completion(projs, nil);
        }
    }];
}

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
