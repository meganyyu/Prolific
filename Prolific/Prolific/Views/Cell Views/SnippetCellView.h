//
//  SnippetCellView.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SnippetCellView : UIView

@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *seedContentLabel;
@property (nonatomic, strong) UILabel *voteCountLabel;

@end

NS_ASSUME_NONNULL_END
