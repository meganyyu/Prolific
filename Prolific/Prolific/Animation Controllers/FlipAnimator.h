//
//  FlipAnimator.h
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlipAnimator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDuration:(NSTimeInterval)duration
                    isPresenting:(BOOL)isPresenting
                     originFrame:(CGRect)originFrame;

@end

NS_ASSUME_NONNULL_END
