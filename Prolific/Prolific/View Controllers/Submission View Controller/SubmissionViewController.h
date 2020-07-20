//
//  SubmissionViewController.h
//  Prolific
//
//  Created by meganyu on 7/17/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "Round.h"
#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SubmissionViewControllerDelegate

- (void)didSubmit:(Snippet *)snippet round:(Round *)round;

@end

@interface SubmissionViewController : ProlificBaseViewController

@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) Round *round;
@property (nonatomic, weak) id<SubmissionViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
