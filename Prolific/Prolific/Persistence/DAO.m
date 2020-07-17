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

- (void)saveUser:(User *)user {
    
    NSDictionary *const userData = @{
        kUsernameKey: user.username,
        kDisplayNameKey: user.displayName
    };
    
    [[[_db collectionWithPath:kUsersKey] documentWithPath:user.userId] setData:userData
                                                                       merge:YES
                                                                  completion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error adding document: %@", error);
        } else {
            NSLog(@"Document successfully written with user ID: %@", user.userId);
        }
    }];
}

#pragma mark - Snippet

- (void)createSnippet:(Snippet *)snippet forProjectId:(NSString *)projId {
    [self getProjectWithId:projId completion:^(Project * _Nonnull project, NSError * _Nonnull error) {
        NSNumber *const currentRound = project.currentRound;
    }];
    
    NSDictionary *const snippetData = @{
        kAuthorIdKey: snippet.authorId,
        kTextKey: snippet.text
    };
    
    __block FIRDocumentReference *ref =
    [[self.db collectionWithPath:kProjectsKey] addDocumentWithData:snippetData
                                                     completion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error adding document: %@", error);
        } else {
            NSLog(@"Document added with ID: %@", ref.documentID);
        }
    }];
}

#pragma mark - Projects

- (void)getAllProjectsWithCompletion:(void(^)(NSArray *projects, NSError *error))completion {
    [[self.db collectionWithPath:kProjectsKey]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if (error != nil) {
            NSLog(@"Error getting project documents from Firestore: %@", error);
            
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
            NSLog(@"Project document with id %@ does not exist, or data invalid", projectId);
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
        NSLog(@"Snippet successfully built from data!: %@", snippet);
        return snippet;
    } else {
        NSLog(@"Can't build snippet from data.");
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
        NSLog(@"Round successfully built from data!: %@", round);
        return round;
    } else {
        NSLog(@"Can't build round from data.");
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
        NSLog(@"Project successfully built from data!: %@", proj);
        return proj;
    } else {
        NSLog(@"Can't build project from data.");
        return nil;
    }
}

@end
