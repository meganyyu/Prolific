//
//  RoundBuilder.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

@class Round;

#import "Entity.h"

#import "Round.h"
#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundBuilder : EntityBuilder

@property (nonatomic, strong, readonly) NSString *roundId;
@property (nonatomic, readonly) BOOL *isComplete;
@property (nonatomic, strong, readonly) NSMutableArray<Snippet *> *submissions;

#pragma mark - Methods

- (RoundBuilder *)withId:(NSString *)roundId;

- (RoundBuilder *)addSubmission:(Snippet *)snippet;

- (Round *)build;

@end

NS_ASSUME_NONNULL_END
