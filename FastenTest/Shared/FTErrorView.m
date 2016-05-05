//
//  FTErrorView.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 05/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTErrorView.h"
#import "APLColorScheme.h"

#import <PureLayout.h>

@interface FTErrorView ()

@end

@implementation FTErrorView

- (void)setupView
{
    self.backgroundColor = APLCSC(Color_Red);
    
    self.textlabel = [UILabel new];
    self.textlabel.numberOfLines = 0;
    self.textlabel.textColor = APLCSC(Color_White);
    self.textlabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textlabel];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.textlabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
}

@end
