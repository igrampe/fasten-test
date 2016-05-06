//
//  FTStatusViewInput.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 06/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef FTStatusViewInput_h
#define FTStatusViewInput_h

#import <Foundation/Foundation.h>

@protocol FTStatusViewInput <NSObject>

- (void)showExpirationDate:(NSString *)dateString;
- (void)showNotice:(NSString *)notice;

@end

#endif /* FTStatusViewInput_h */
