//
//  SubmissionsViewController.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "Round.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubmissionsViewController : ProlificBaseViewController

@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) Round *round;
@property (nonatomic, strong) User *currUser;

@end

NS_ASSUME_NONNULL_END
