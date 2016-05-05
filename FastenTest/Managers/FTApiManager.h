//
//  FTApiManager.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 04/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FTApiManagerSignInHandler)(NSString *apiToken, NSDate *apiTokenExpiration, NSError *error);

extern NSString *const FTApiManagerErrorDomain;

@interface FTApiManager : NSObject

- (void)start;

- (void)signinWithEmail:(NSString *)email password:(NSString *)password handler:(FTApiManagerSignInHandler)handler;

@end
