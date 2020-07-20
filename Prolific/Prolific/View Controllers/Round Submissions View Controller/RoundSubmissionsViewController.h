//
//  RoundSubmissionsViewController.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "Round.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundSubmissionsViewController : ProlificBaseViewController

@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) Round *round;

@end

NS_ASSUME_NONNULL_END
