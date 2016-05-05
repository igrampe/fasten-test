//
//  FTRoundedButton.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 05/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTRoundedButton.h"

@implementation FTRoundedButton

- (void)setupView
{
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
}

@end
