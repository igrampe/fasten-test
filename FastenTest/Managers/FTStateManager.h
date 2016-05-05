//
//  FTStateManager.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 04/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTStateManager : NSObject

@property (nonatomic, strong, readonly) NSString *apiToken;
@property (nonatomic, strong, readonly) NSDate *apiTokenExpirationDate;

- (void)setApiToken:(NSString *)apiToken withExpirationDate:(NSDate *)expirationDate;
- (void)resetApiToken;

- (BOOL)isAuthorized;

@end
