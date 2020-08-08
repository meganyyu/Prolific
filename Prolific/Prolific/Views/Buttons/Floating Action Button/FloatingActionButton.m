//
//  FloatingActionButton.m
//  Prolific
//
//  Created by meganyu on 8/7/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FloatingActionButton.h"

@implementation FloatingActionButton

- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = rect.size.height / 2.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.25;
    self.layer.shadowRadius = 5;
    self.layer.shadowOffset = CGSizeMake(0, 10);
}

@end
