//
//  ButtonCell.m
//  Prolific
//
//  Created by meganyu on 7/27/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "TextCell.h"
#import "UIColor+ProlificColors.h"

static NSString *const kRoundComposeIconId = @"round-compose-icon";

@interface TextCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIButton *composeButton;

@end

@implementation TextCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor ProlificBackgroundGrayColor];
        
        _cellView = [[UIView alloc] initWithFrame:frame];
        [self.contentView addSubview:_cellView];
        
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        self.layer.shadowRadius = 0.0;
        self.layer.shadowOpacity = 0.0;
        
        _composeButton = [[UIButton alloc] init];
        [_composeButton setImage:[UIImage imageNamed:kRoundComposeIconId] forState:normal];
        _composeButton.tintColor = [UIColor whiteColor];
        [_composeButton addTarget:self
                           action:@selector(onTapCompose:)
                 forControlEvents:UIControlEventTouchUpInside];
        [_cellView addSubview:_composeButton];
    }
    return self;
}

- (void)layoutSubviews {
    _cellView.frame = self.contentView.bounds;
    
    CGFloat const composeButtonWidth = 100;
    CGFloat const composeButtonHeight = 100;
    CGFloat const composeButtonX = _cellView.center.x - composeButtonWidth / 2.0;
    CGFloat const composeButtonY = _cellView.center.y - composeButtonHeight / 2.0;
    _composeButton.frame = CGRectMake(composeButtonX, composeButtonY, composeButtonWidth, composeButtonHeight);
}

@end
