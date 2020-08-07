//
//  HorizontalProgressBar.h
//  Prolific
//
//  Created by meganyu on 8/6/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HorizontalProgressBar : UIView

@property (nonatomic) CGFloat progress;

- (void)setProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
