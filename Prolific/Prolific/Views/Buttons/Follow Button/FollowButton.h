//
//  FollowButton.h
//  Prolific
//
//  Created by meganyu on 7/28/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FollowButtonDelegate

- (void)didFollow;

@end

@interface FollowButton : UIButton

@property (nonatomic, weak) id<FollowButtonDelegate> delegate;
@property (nonatomic) BOOL isTapped;

@end

NS_ASSUME_NONNULL_END
