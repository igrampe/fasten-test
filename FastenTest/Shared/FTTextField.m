//
//  FTTextField.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 05/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTTextField.h"

#import "APLColorScheme.h"
#import <PureLayout.h>

@interface FTTextField ()

@property (nonatomic, strong, readwrite) UITextField *textField;
@property (nonatomic, strong) UIView *separatorView;

@end

@implementation FTTextField

- (void)setupView
{
    self.textField = [UITextField newAutoLayoutView];
    [self addSubview:self.textField];
    
    self.separatorView = [UIView newAutoLayoutView];
    self.separatorView.backgroundColor = APLCSC(Color_Gray);
    [self addSubview:self.separatorView];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.textField autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.textField autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.textField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.textField autoSetDimension:ALDimensionHeight toSize:[self height]-2];
    
    [self.separatorView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.textField];
    [self.separatorView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.textField];
    [self.separatorView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.textField withOffset:-2];
    [self.separatorView autoSetDimension:ALDimensionHeight toSize:2];
}

- (CGFloat)height
{
    return 26;
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    self.separatorView.backgroundColor = _highlighted?APLCSC(Color_Red):APLCSC(Color_Gray);
}

@end
