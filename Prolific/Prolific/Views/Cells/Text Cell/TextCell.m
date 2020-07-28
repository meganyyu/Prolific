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
        
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        self.layer.shadowRadius = 0.0;
        self.layer.shadowOpacity = 0.0;
        self.clipsToBounds = YES;
        
        _cellView = [[UIView alloc] initWithFrame:frame];
        [self.contentView addSubview:_cellView];
        
        _composeTextView = [[UITextView alloc] init];
        _composeTextView.delegate = self;
        _composeTextView.backgroundColor = [UIColor ProlificGray1Color];
        _composeTextView.textColor = [UIColor darkGrayColor];
        _composeTextView.text = @"\n\nWhat happens next?";
        [_composeTextView setFont:[UIFont systemFontOfSize:18]];
        [_cellView addSubview:_composeTextView];
    }
    return self;
}

- (void)layoutSubviews {
    _cellView.frame = self.contentView.bounds;
    _composeTextView.frame = _cellView.frame;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [_delegate didTapCompose];
    return NO;
}

@end
