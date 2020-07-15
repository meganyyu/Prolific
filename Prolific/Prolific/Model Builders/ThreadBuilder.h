//
//  ThreadBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Thread;

#import "Entity.h"

#import "Thread.h"
#import "Round.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreadBuilder : EntityBuilder

@property (nonatomic, strong) NSString *threadId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL *isComplete;
@property (nonatomic, strong) NSMutableArray<Round *> *rounds;

- (ThreadBuilder *)withId:(NSString *)threadId;

- (ThreadBuilder *)withName:(NSString *)threadName;

- (ThreadBuilder *)addRound:(NSString *)aRound;

- (Thread *)build;

@end

NS_ASSUME_NONNULL_END
