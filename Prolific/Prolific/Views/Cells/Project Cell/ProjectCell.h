//
//  ProjectPreviewCell.h
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCell.h"

#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProjectCellDelegate;

@interface ProjectCell : BaseCell

@property (nonatomic, strong) Project *project;
@property (nonatomic, weak) id<ProjectCellDelegate> delegate;

@end

@protocol ProjectCellDelegate

@end

NS_ASSUME_NONNULL_END
