//
//  ProjectPreviewCell.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProjectCell.h"

static NSString *const kTappedFollowIconID = @"tapped-follow-icon";
static NSString *const kUntappedFollowIconID = @"untapped-follow-icon";

#pragma mark - Implementation

@implementation ProjectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellView = [[ProjectCellView alloc] initWithFrame:frame];
        [self.contentView addSubview:_cellView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cellView.frame = self.contentView.bounds;
    
    _cellView.nameLabel.text = _project.name;
    _cellView.seedContentLabel.text = _project.seed;
    _cellView.followCountLabel.text = [_project.followCount stringValue];
    
    [_cellView.followButton addTarget:self
                               action:@selector(onTapFollow:)
                     forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - User actions

- (void)onTapFollow:(id)sender {
    [_project updateCurrentUserFollowing];
    [_delegate didFollow:_project];
    
    UIImage *const followIcon = [UIImage imageNamed:(_project.userFollowed ? kTappedFollowIconID : kUntappedFollowIconID)];
    [_cellView.followButton setImage:followIcon
                            forState:UIControlStateNormal];
    
    _cellView.followCountLabel.text = [_project.followCount stringValue];
}

@end
