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

static NSString *const kDisplayNameKey = @"displayName";
static NSString *const kNameKey = @"name";
static NSString *const kIsCompleteKey = @"isComplete";
static NSString *const kProjectsKey = @"projects";
static NSString *const kSeedKey = @"seed";
static NSString *const kCurrentRoundKey = @"currentRound";
static NSString *const kUsersKey = @"users";
static NSString *const kUsernameKey = @"username";

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
    FIRDocumentReference *docRef =
    [[self.db collectionWithPath:kProjectsKey] documentWithPath:projectId];
    [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
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

- (Project *)buildProjectWithId:(NSString *)projectId
                       fromData:(NSDictionary *)data {
    ProjectBuilder *const projbuilder = [[ProjectBuilder alloc] init];
    Project *const proj = [[[[[[projbuilder
                                withId:projectId]
                               withName:data[kNameKey]]
                              withSeed:data[kSeedKey]]
                             withCurrentRoundNumber:data[kCurrentRoundKey]]
                            isComplete:data[kIsCompleteKey]]
                           build];
    
    if (proj != nil) {
        NSLog(@"Project successfully built from data!: %@", proj);
        return proj;
    } else {
        NSLog(@"Can't build project from data.");
        return nil;
    }
}

@end
