//
//  FTAuthViewOutput.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef FTAuthViewOutput_h
#define FTAuthViewOutput_h

#import <Foundation/Foundation.h>

@protocol FTAuthViewOutput <NSObject>

- (void)viewWillAppear;
- (void)actionSignIn;

@end

#endif /* FTAuthViewOutput_h */
