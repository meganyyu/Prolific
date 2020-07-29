//
//  ProjectPreviewCell.h
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCell.h"

#import "Project.h"
#import "ProjectCellView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProjectCellDelegate

- (void)didFollow:(Project *)project;

@end

@interface ProjectCell : BaseCell

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) ProjectCellView *cellView;
@property (nonatomic, weak) id<ProjectCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
