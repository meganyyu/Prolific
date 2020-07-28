//
//  ButtonCell.m
//  Prolific
//
//  Created by meganyu on 7/27/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "TextCell.h"
#import "UIColor+ProlificColors.h"

@interface TextCell () <UITextViewDelegate>

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UITextView *composeTextView;

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
        
        _composeTextView = [[UITextView alloc] init];
        _composeTextView.tintColor = [UIColor whiteColor];
        _composeTextView.textColor = [UIColor grayColor];
        _composeTextView.text = @"What happens next?";
        [_cellView addSubview:_composeTextView];
    }
    return self;
}

- (void)layoutSubviews {
    _cellView.frame = self.contentView.bounds;
    _composeTextView.frame = _cellView.frame;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [_delegate didTapCompose];
    return NO;
}

@end
