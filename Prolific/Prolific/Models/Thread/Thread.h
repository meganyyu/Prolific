//
//  Thread.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class ThreadBuilder;

#import "Entity.h"

#import "Round.h"
#import "ThreadBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Thread : Entity

#pragma mark - Properties

// required (and immutable) attributes
@property (nonatomic, readonly) NSString *threadId;
@property (nonatomic, readonly) NSString *threadName;

// required (and mutable) attributes
@property (nonatomic, readonly) BOOL *isComplete;
@property (nonatomic, readonly) NSMutableArray<Round *> *rounds;

#pragma mark - Methods

- (instancetype)initWithBuilder:(ThreadBuilder *)builder;

@end

NS_ASSUME_NONNULL_END
