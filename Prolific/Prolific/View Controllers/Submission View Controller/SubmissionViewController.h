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

@interface SubmissionViewController : ProlificBaseViewController

@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) Round *round;

@end

NS_ASSUME_NONNULL_END
