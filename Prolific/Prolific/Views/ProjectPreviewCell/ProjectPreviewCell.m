//
//  ProjectPreviewCell.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectPreviewCell.h"

@interface ProjectPreviewCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;

@end

@implementation ProjectPreviewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        _cellView = [[UIView alloc] init];
        _cellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_cellView];
        
        _nameLabel = [[UILabel alloc] init];
        //_nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.numberOfLines = 0;
        [_cellView addSubview:_nameLabel];
        
        _seedContentLabel = [[UILabel alloc] init];
        //_seedContentLabel.backgroundColor = [UIColor whiteColor];
        _seedContentLabel.textColor = [UIColor blackColor];
        _seedContentLabel.numberOfLines = 0;
        [_cellView addSubview:_seedContentLabel];
        
        NSLog(@"Created cells!");
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect const bounds = self.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    
    // cell view
    _cellView.frame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    // project name label
    CGFloat const labelWidth = 0.9 * boundsWidth;
    CGFloat const labelX = 0.05 * boundsWidth;
    CGFloat const nameLabelHeight = 0.2 * boundsHeight;
    CGFloat const nameLabelY = 0.05 * boundsHeight;
    NSLog(@"labelWidth: %f, nameLabelHeight: %f, labelX: %f, nameLabelY: %f", labelWidth, nameLabelHeight, labelX, nameLabelY);
    _nameLabel.frame = CGRectMake(labelX, nameLabelY, labelWidth, nameLabelHeight);
    _nameLabel.text = _project.name;
    
    // seed content label
    CGFloat const seedContentLabelHeight = 0.6 * boundsHeight;
    CGFloat const seedContentLabelY = nameLabelHeight + 0.05 * boundsHeight;
    NSLog(@"labelWidth: %f, seedContentLabelHeight: %f, labelX: %f, seedContentLabelY: %f", labelWidth, seedContentLabelHeight, labelX, seedContentLabelY);
    _seedContentLabel.frame = CGRectMake(labelX, seedContentLabelY, labelWidth, seedContentLabelHeight);
    _seedContentLabel.text = _project.seed;
}

@end
