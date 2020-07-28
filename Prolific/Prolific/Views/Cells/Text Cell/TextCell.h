//
//  ButtonCell.h
//  Prolific
//
//  Created by meganyu on 7/27/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TextCellDelegate;

@interface TextCell : BaseCell

@property (nonatomic, weak) id<TextCellDelegate> delegate;

@end

@protocol TextCellDelegate

- (void)didTapCompose;

@end

NS_ASSUME_NONNULL_END
