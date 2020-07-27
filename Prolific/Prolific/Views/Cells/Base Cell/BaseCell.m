//
//  BaseCellCollectionViewCell.m
//  Prolific
//
//  Created by meganyu on 7/20/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "BaseCell.h"

@interface BaseCell ()

@end

@implementation BaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(4.0, 4.0);
        self.layer.shadowRadius = 20.0;
        self.layer.shadowOpacity = 0.25;
        self.layer.cornerRadius = 10.0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
