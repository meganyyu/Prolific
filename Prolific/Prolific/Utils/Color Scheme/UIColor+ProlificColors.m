//
//  UIColor+ProlificColors.m
//  Prolific
//
//  Created by meganyu on 7/22/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "UIColor+ProlificColors.h"

@implementation UIColor (ProlificColors)

+ (UIColor *)ProlificPrimaryBlueColor {
    static UIColor *prolificPrimaryBlueColor;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificPrimaryBlueColor = [UIColor colorWithRed:61.0 / 255.0
                                           green:90.0 / 255.0
                                            blue:128.0 / 255.0
                                           alpha:1.0];
    });

    return prolificPrimaryBlueColor;
}

+ (UIColor *)ProlificRedColor {
    static UIColor *prolificRedColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificRedColor = [UIColor colorWithRed:238.0 / 255.0
                                           green:108.0 / 255.0
                                            blue:77.0 / 255.0
                                           alpha:1.0];
    });

    return prolificRedColor;
}

+ (UIColor *)ProlificGray1Color {
    static UIColor *prolificGray1Color;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificGray1Color = [UIColor colorWithRed:229.0 / 255.0
                                           green:229.0 / 255.0
                                            blue:229.0 / 255.0
                                           alpha:1.0];
    });

    return prolificGray1Color;
}

+ (UIColor *)ProlificGray2Color {
    static UIColor *prolificGray2Color;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificGray2Color = [UIColor colorWithRed:177.0 / 255.0
                                           green:177.0 / 255.0
                                            blue:177.0 / 255.0
                                           alpha:1.0];
    });

    return prolificGray2Color;
}

+ (UIColor *)ProlificBackgroundGrayColor {
    static UIColor *prolificBackgroundGrayColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificBackgroundGrayColor = [UIColor colorWithRed:249.0 / 255.0
                                           green:249.0 / 255.0
                                            blue:249.0 / 255.0
                                           alpha:1.0];
    });

    return prolificBackgroundGrayColor;
}

@end
