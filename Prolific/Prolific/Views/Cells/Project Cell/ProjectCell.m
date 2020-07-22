//
//  ProjectPreviewCell.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectCell.h"

#import "ProjectCellView.h"

#pragma mark - Interface

@interface ProjectCell ()

@property (nonatomic, strong) ProjectCellView *cellView;

@end

#pragma mark - Implementation

@implementation ProjectCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect const bounds = self.bounds;
    CGFloat const boundsWidth = CGRectGetWidth(bounds);
    CGFloat const boundsHeight = CGRectGetHeight(bounds);
    CGRect const cellFrame = CGRectMake(0, 0, boundsWidth, boundsHeight);
    
    _cellView = [[ProjectCellView alloc] initWithFrame:cellFrame];
    [self addSubview:_cellView];
    
    _cellView.nameLabel.text = _project.name;
    _cellView.seedContentLabel.text = _project.seed;
}

@end
