//
//  FTStatusViewController.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 06/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+APL.h"
#import "FTStatusViewInput.h"

@protocol FTStatusViewOutput;

@interface FTStatusViewController : UIViewController <FTStatusViewInput>

@property (nonatomic, weak) id<FTStatusViewOutput> output;

@end
