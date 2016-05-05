//
//  FTTextField.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 05/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTView.h"

@interface FTTextField : FTView

@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, assign) BOOL highlighted;

- (CGFloat)height;

@end
