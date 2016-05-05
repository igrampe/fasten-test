//
//  FTRootViewController.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+APL.h"
#import "FTRootViewInput.h"

@protocol FTRootViewOutput;

@interface FTRootViewController : UIViewController <FTRootViewInput>

@property (nonatomic, weak) id<FTRootViewOutput> output;

@end
