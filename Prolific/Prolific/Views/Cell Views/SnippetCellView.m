//
//  SnippetCellView.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "SnippetCellView.h"

@implementation SnippetCellView

- (void)drawRect:(CGRect)rect {
    CGFloat const boundsWidth = CGRectGetWidth(rect);
    CGFloat const boundsHeight = CGRectGetHeight(rect);
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    
    // cell view
    self.frame = rect;
    self.backgroundColor = [UIColor whiteColor];
    
    // project name label
    _usernameLabel = [[UILabel alloc] init];
    _usernameLabel.textColor = [UIColor blackColor];
    _usernameLabel.numberOfLines = 0;
    CGFloat const nameLabelHeight = 0.2 * boundsHeight;
    CGFloat const nameLabelY = 0.05 * boundsHeight;
    _usernameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    [self addSubview:_usernameLabel];
    
    // seed content label
    _seedContentLabel = [[UILabel alloc] init];
    _seedContentLabel.textColor = [UIColor blackColor];
    _seedContentLabel.numberOfLines = 0;
    CGFloat const seedContentLabelHeight = 0.6 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
    [self addSubview:_seedContentLabel];
}

@end
