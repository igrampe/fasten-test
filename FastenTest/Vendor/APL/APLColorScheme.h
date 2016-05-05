//
//  APLColorScheme.h
//  Client
//
//  Created by Semyon Belokovsky on 17/11/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorSchemeHeader.h"

@interface APLColorScheme : NSObject

+ (void)registerColorScheme;
+ (void)registerColorWithHex:(NSString *)hex forName:(NSString *)name;
+ (UIColor *)colorWithName:(NSString *)name;

UIColor* UIColorWithName(NSString *name);

@end

#define APLCSC(x) ([APLColorScheme colorWithName:x])