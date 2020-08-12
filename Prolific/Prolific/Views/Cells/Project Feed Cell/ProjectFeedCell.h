//
//  ProjectFeedCell.h
//  Prolific
//
//  Created by meganyu on 8/11/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "FeedCell.h"

#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectFeedCell : FeedCell

@property (nonatomic, strong) NSArray<Project *> *projects;

@end

NS_ASSUME_NONNULL_END
