//
//  FTAuthViewInput.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef FTAuthViewInput_h
#define FTAuthViewInput_h

#import <Foundation/Foundation.h>

@protocol FTAuthViewInput <NSObject>

- (void)showLoader;
- (void)hideLoader;
- (void)showErrorWithMessage:(NSString *)message;
- (void)hideError;
- (void)deactivateTextField;

- (NSString *)valueEmail;
- (NSString *)valuePassword;

@end

#endif /* FTAuthViewInputt_h */
