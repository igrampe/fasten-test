//
//  FTAuthViewController.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+APL.h"
#import "FTAuthViewInput.h"

@protocol FTAuthViewOutput;

@interface FTAuthViewController : UIViewController <FTAuthViewInput>

@property (nonatomic, weak) id<FTAuthViewOutput> output;

@end
