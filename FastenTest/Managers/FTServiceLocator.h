//
//  FTServiceLocator.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTApiManager;
@class FTStateManager;

@interface FTServiceLocator : NSObject

@property (nonatomic, strong, readonly) FTApiManager *apiManager;
@property (nonatomic, strong, readonly) FTStateManager *stateManager;

- (void)start;

@end
