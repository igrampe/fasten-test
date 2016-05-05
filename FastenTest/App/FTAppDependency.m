//
//  FTAppDependency.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTAppDependency.h"
#import "FTServiceLocator.h"
#import "FTRootWireframe.h"
#import "APLColorScheme.h"

@interface FTAppDependency ()

@property (nonatomic, strong) FTServiceLocator *serviceLocator;
@property (nonatomic, strong) FTRootWireframe *rootWireframe;

@end

@implementation FTAppDependency

- (void)setupApplication:(UIApplication *)application withOptions:(NSDictionary *)options
{
    [self _startServiceLocator];
    [self _registerColorScheme];
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    [self.rootWireframe presentViewFromWindow:window];
}

#pragma mark - Private

- (void)_startServiceLocator
{
    [self.serviceLocator start];
}

- (void)_registerColorScheme
{
    [APLColorScheme registerColorScheme];
}

#pragma mark - Lazy

- (FTServiceLocator *)serviceLocator
{
    if (!_serviceLocator)
    {
        _serviceLocator = [FTServiceLocator new];
    }
    return _serviceLocator;
}

- (FTRootWireframe *)rootWireframe
{
    if (!_rootWireframe)
    {
        _rootWireframe = [FTRootWireframe new];
        _rootWireframe.serviceLocator = self.serviceLocator;
    }
    return _rootWireframe;
}

@end
