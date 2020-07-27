//
//  CircularProgressBar.m
//  Prolific
//
//  Created by meganyu on 7/27/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "CircularProgressBar.h"

@interface CircularProgressBar ()

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@end
@implementation CircularProgressBar

- (instancetype)init {
    self = [super init];
    if (self) {
        _progress = 100;
        
        _startAngle = M_PI * 1.5;
        _endAngle = _startAngle + (M_PI * 2);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat innerCircleRadius = 50;
    CGFloat backgroundCircleRadius = 83;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0)
                                                        radius:innerCircleRadius
                                                    startAngle:_startAngle
                                                      endAngle:(_endAngle - _startAngle) * _progress + _startAngle clockwise:YES];
    
    UIBezierPath *backgroundCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0)
                                                                        radius:backgroundCircleRadius
                                                                    startAngle:_startAngle
                                                                      endAngle:_endAngle
                                                                     clockwise:YES];
    
    CAShapeLayer *backgroundCircle = [CAShapeLayer layer];
    backgroundCircle.path = backgroundCirclePath.CGPath;
    backgroundCircle.fillColor = [UIColor grayColor].CGColor;
    backgroundCircle.opacity = 0.3;
    
    [self.layer addSublayer:backgroundCircle];
    
    CAShapeLayer *progressCircle = [CAShapeLayer layer];
    progressCircle.path = circlePath.CGPath;
    progressCircle.strokeColor = [UIColor lightGrayColor].CGColor;
    progressCircle.fillColor = [UIColor clearColor].CGColor;
    progressCircle.lineWidth = 10;
    
    [self.layer addSublayer:progressCircle];
}

@end
