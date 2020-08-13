//
//  UnderlinedTextField.m
//  Prolific
//
//  Created by meganyu on 8/12/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "UnderlinedTextField.h"

#import "UIColor+ProlificColors.h"

@implementation UnderlinedTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // text field's bottom border
    CALayer *const border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor ProlificGray2Color].CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    [super textRectForBounds:bounds];
    
    return CGRectInset(bounds, 0, 5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    [super editingRectForBounds:bounds];
    
    return CGRectInset(bounds, 0, 5);
}

@end
