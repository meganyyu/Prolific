//
//  ComposeSnippetViewController.h
//  Prolific
//
//  Created by meganyu on 7/17/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "ProlificBaseViewController.h"

#import "Round.h"
#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeSnippetViewControllerDelegate

- (void)didSubmit:(Snippet *)snippet round:(Round *)round;

@end

@interface ComposeSnippetViewController : ProlificBaseViewController

@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) Round *round;
@property (nonatomic, weak) id<ComposeSnippetViewControllerDelegate> delegate;

- (instancetype)initWithRound:(Round *)round
                    projectId:(NSString *)projectId;

@end

NS_ASSUME_NONNULL_END
