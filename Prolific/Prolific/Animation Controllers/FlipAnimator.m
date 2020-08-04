//
//  FlipAnimator.m
//  Prolific
//
//  Created by meganyu on 8/3/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FlipAnimator.h"

@interface FlipAnimator ()

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) CGRect originFrame;
@property (nonatomic) BOOL isPresenting;

@end

@implementation FlipAnimator

- (instancetype)initWithDuration:(NSTimeInterval)duration
                    isPresenting:(BOOL)isPresenting
                     originFrame:(CGRect)originFrame {
    _duration = duration;
    _isPresenting = isPresenting;
    _originFrame = originFrame;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *const containerView = transitionContext.containerView;
    UIViewController *const fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIViewController *const toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *const snapshot = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    CGRect const finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    snapshot.frame = _originFrame;
    snapshot.layer.masksToBounds = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:snapshot];
    [toViewController.view setHidden:YES];
    
    [self persectiveTransform:containerView];
    snapshot.layer.transform = [self yRotation:(M_PI / 2.0)];
    
    NSTimeInterval const duration = [self transitionDuration:transitionContext];
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:1.0/3.0
                                      animations:^{
            fromViewController.view.layer.transform = [self yRotation:(-M_PI / 2.0)];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1.0/3.0
                                relativeDuration:1.0/3.0
                                      animations:^{
            snapshot.layer.transform = [self yRotation:0.0];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2.0/3.0
                                relativeDuration:1.0/3.0
                                      animations:^{
            snapshot.frame = finalFrame;
        }];
    } completion:^(BOOL finished) {
        [toViewController.view setHidden:NO];
        [snapshot removeFromSuperview];
        fromViewController.view.layer.transform = CATransform3DIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

#pragma mark - Animation helper functions

- (CATransform3D)yRotation:(CGFloat)angle {
    return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}

- (void)persectiveTransform:(UIView *)containerView {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
}

@end
