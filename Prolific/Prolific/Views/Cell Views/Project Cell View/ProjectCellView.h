//
//  ProjectCellView.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCellView.h"

#import "CountLabel.h"
#import "FollowButton.h"
#import "Project.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectCellView : BaseCellView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;
@property (nonatomic, strong) CountLabel *roundCountLabel;
@property (nonatomic, strong) CountLabel *followCountLabel;
@property (nonatomic, strong) FollowButton *followButton;
@property (nonatomic, strong) Project *project;

@end

NS_ASSUME_NONNULL_END
