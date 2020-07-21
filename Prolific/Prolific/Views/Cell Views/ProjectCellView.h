//
//  ProjectCellView.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectCellView : BaseCellView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;
@property (nonatomic, strong) UILabel *roundCountLabel;

@end

NS_ASSUME_NONNULL_END