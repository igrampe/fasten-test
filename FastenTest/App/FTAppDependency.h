//
//  FTAppDependency.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTAppDependency : NSObject

- (void)setupApplication:(UIApplication *)application withOptions:(NSDictionary *)options;
- (void)installRootViewControllerIntoWindow:(UIWindow *)window;

@end
