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
        prolificPrimaryBlueColor = [UIColor colorWithRed:67.0 / 255.0
                                                   green:165.0 / 255.0
                                                    blue:178.0 / 255.0
                                                   alpha:1.0];
    });
    
    return prolificPrimaryBlueColor;
}

+ (UIColor *)ProlificBlue1Color {
    static UIColor *prolificBlue1Color;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificBlue1Color = [UIColor colorWithRed:85.0 / 255.0
                                             green:179.0 / 255.0
                                              blue:191.0 / 255.0
                                             alpha:1.0];
    });
    
    return prolificBlue1Color;
}

+ (UIColor *)ProlificBlue2Color {
    static UIColor *prolificBlue2Color;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificBlue2Color = [UIColor colorWithRed:134.0 / 255.0
                                             green:218.0 / 255.0
                                              blue:218.0 / 255.0
                                             alpha:1.0];
    });
    
    return prolificBlue2Color;
}

+ (UIColor *)ProlificGoldColor {
    static UIColor *prolificGoldColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificGoldColor = [UIColor colorWithRed:251.0 / 255.0
                                            green:200.0 / 255.0
                                             blue:137.0 / 255.0
                                            alpha:1.0];
    });
    
    return prolificGoldColor;
}

+ (UIColor *)ProlificRedColor {
    static UIColor *prolificRedColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prolificRedColor = [UIColor colorWithRed:255.0 / 255.0
                                           green:115.0 / 255.0
                                            blue:116.0 / 255.0
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
