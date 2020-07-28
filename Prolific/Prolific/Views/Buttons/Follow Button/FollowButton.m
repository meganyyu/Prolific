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
        
        _isTapped = NO;
        
        [self setImage:[UIImage imageNamed:kUntappedFollowIconID]
              forState:normal];
        [self addTarget:self action:@selector(onTapFollow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIImage *const followIcon = [UIImage imageNamed:(_isTapped ? kTappedFollowIconID : kUntappedFollowIconID)];
    [self setImage:followIcon forState:UIControlStateNormal];
}

- (void)onTapFollow:(id)sender {
    _isTapped = !_isTapped;
    
    [self setNeedsLayout];
    [_delegate didFollow];
}

@end
