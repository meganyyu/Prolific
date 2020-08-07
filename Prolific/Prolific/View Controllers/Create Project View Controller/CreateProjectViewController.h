//
//  CreateProjectViewController.h
//  Prolific
//
//  Created by meganyu on 8/7/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "Project.h"
NS_ASSUME_NONNULL_BEGIN

@protocol CreateProjectViewControllerDelegate

- (void)didCreateProject:(Project *)project;

@end

@interface CreateProjectViewController : ProlificBaseViewController

@property (nonatomic, weak) id<CreateProjectViewControllerDelegate> delegate;

- (instancetype)initWithDelegate:(id<CreateProjectViewControllerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
