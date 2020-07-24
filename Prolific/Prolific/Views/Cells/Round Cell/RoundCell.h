//
//  RoundCell.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCell.h"

#import "Snippet.h"
#import "RoundCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundCell : BaseCell

@property (nonatomic, strong, nullable) Snippet *snippet;
@property (nonatomic, strong) RoundCellView *cellView;

@end

NS_ASSUME_NONNULL_END
