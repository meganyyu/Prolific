//
//  SnippetCellView.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCellView.h"

#import "CountLabel.h"
#import "VoteButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface SnippetCellView : BaseCellView

@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;
@property (nonatomic, strong) VoteButton *voteButton;
@property (nonatomic, strong) CountLabel *voteCountLabel;

@end

NS_ASSUME_NONNULL_END
