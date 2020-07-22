//
//  SnippetCell.h
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCell.h"

#import "Snippet.h"
#import "SnippetCellView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SnippetCellDelegate;

@interface SnippetCell : BaseCell

@property (nonatomic, strong) Snippet *snippet;
@property (nonatomic, strong) SnippetCellView *cellView;
@property (nonatomic, weak) id<SnippetCellDelegate> delegate;

@end

@protocol SnippetCellDelegate

- (void)didVote:(Snippet *)snippet;

@end

NS_ASSUME_NONNULL_END
