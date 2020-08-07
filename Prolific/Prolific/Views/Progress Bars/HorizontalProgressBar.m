//
//  HorizontalProgressBar.m
//  Prolific
//
//  Created by meganyu on 8/6/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "HorizontalProgressBar.h"

#import "UIColor+ProlificColors.h"

@interface HorizontalProgressBar ()

@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation HorizontalProgressBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor ProlificGray1Color];
        
        _progressLayer = [CALayer layer];
        [self.layer addSublayer:_progressLayer];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CAShapeLayer *const backgroundMask = [CAShapeLayer layer];
    backgroundMask.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height * 0.25].CGPath;
    self.layer.mask = backgroundMask;
    
    CGRect progressRect = CGRectMake(0, 0, rect.size.width * _progress, rect.size.height);
    _progressLayer.frame = progressRect;
    _progressLayer.backgroundColor = [UIColor ProlificGoldColor].CGColor;
}

@end
