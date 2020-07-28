//
//  FollowButton.m
//  Prolific
//
//  Created by meganyu on 7/28/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FollowButton.h"

static NSString *const kTappedFollowIconID = @"tapped-follow-icon";
static NSString *const kUntappedFollowIconID = @"untapped-follow-icon";

@implementation FollowButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect newFrame = self.frame;
        newFrame.size = CGSizeMake(30, 30);
        self.frame = newFrame;
        
        [self setImage:[UIImage imageNamed:kUntappedFollowIconID]
              forState:normal];
    }
    return self;
}

@end
