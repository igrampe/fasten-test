//
//  FTWireframe.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef FTWireframe_h
#define FTWireframe_h

#import <UIKit/UIKit.h>

@class FTServiceLocator;

@protocol FTWireframeProtocol <NSObject>

@property (nonatomic, strong) FTServiceLocator *serviceLocator;

@optional

- (void)presentViewFromViewController:(UIViewController *)fromVC;
- (void)presentViewFromWindow:(UIWindow *)fromWindow;

@end

#endif /* FTWireframe_h */
