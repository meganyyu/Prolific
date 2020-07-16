//
//  Round.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class RoundBuilder;

#import "Entity.h"

#import "Snippet.h"
#import "RoundBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Round : Entity

@property (nonatomic, strong, readonly) NSString *roundId;
@property (nonatomic, readonly) BOOL *isComplete;
@property (nonatomic, strong, readonly) NSString *winningSnippetId;
@property (nonatomic, strong, readonly) NSArray<Snippet *> *submissions;

#pragma mark - Methods

- (instancetype)initWithBuilder:(RoundBuilder *)builder;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
