//
//  Round.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Entity.h"

#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Round : Entity

@property (nonatomic, readonly) NSString *roundId;
@property (nonatomic, readonly) BOOL *isComplete;
@property (nonatomic, readonly) NSArray<Snippet *> *submissions;

@end

NS_ASSUME_NONNULL_END
