//
//  CountLabel.m
//  Prolific
//
//  Created by meganyu on 7/21/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "CountLabel.h"

@implementation CountLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect newFrame = self.frame;
        newFrame.size = CGSizeMake(30, 25);
        self.frame = newFrame;
        
        self.textColor = [UIColor systemIndigoColor];
        self.numberOfLines = 1;
        self.font = [self.font fontWithSize:12];
    }
    return self;
}

@end
