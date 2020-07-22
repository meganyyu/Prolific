//
//  VoteButton.m
//  Prolific
//
//  Created by meganyu on 7/21/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "VoteButton.h"

static NSString *const kTappedVoteIconID = @"tapped_vote_icon";
static NSString *const kUntappedVoteIconID = @"untapped_vote_icon";

@implementation VoteButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect newFrame = self.frame;
        newFrame.size = CGSizeMake(15, 15);
        self.frame = newFrame;
        
        [self setImage:[UIImage imageNamed:kUntappedVoteIconID]
              forState:normal];
    }
    return self;
}

@end
