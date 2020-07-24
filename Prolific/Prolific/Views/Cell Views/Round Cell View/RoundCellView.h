//
//  RoundCellView.h
//  Prolific
//
//  Created by meganyu on 7/23/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetCellView.h"

#import "CountLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoundCellView : SnippetCellView

@property (nonatomic, strong) CountLabel *roundCountLabel;
@property (nonatomic, strong) UIButton *openButton;

@end

NS_ASSUME_NONNULL_END
