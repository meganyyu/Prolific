//
//  Snippet.h
//  Prolific
//
//  Created by meganyu on 7/15/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Entity.h"

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Snippet : Entity

@property (nonatomic, strong) NSString *snippetID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) NSNumber *voteCount;
@property (nonatomic, strong) NSDate *createdAtDate;

#pragma mark - Methods

@end

NS_ASSUME_NONNULL_END
