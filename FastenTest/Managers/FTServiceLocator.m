//
//  FTServiceLocator.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTServiceLocator.h"

#import "FTApiManager.h"
#import "FTStateManager.h"

@interface FTServiceLocator ()

@property (nonatomic, strong, readwrite) FTApiManager *apiManager;
@property (nonatomic, strong, readwrite) FTStateManager *stateManager;

@end

@implementation FTServiceLocator

- (void)start
{
    [self.apiManager start];
}

#pragma mark - Lazy

- (FTApiManager *)apiManager
{
    if (!_apiManager)
    {
        _apiManager = [FTApiManager new];
    }
    return _apiManager;
}

- (FTStateManager *)stateManager
{
    if (!_stateManager)
    {
        _stateManager = [FTStateManager new];
    }
    return _stateManager;
}

@end
