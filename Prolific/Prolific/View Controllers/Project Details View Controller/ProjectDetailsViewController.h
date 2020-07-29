//
//  ProjectDetailsViewController.h
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectDetailsViewController : ProlificBaseViewController

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) User *currUser;

@end

NS_ASSUME_NONNULL_END
