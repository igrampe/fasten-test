//
//  APLTextHelper.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Pluralize)

- (NSString *)pluralizedStringWithOne:(NSString *)one
                                  few:(NSString *)few
                                 many:(NSString *)many;

@end

@interface APLTextHelper : NSObject

+ (NSString *)createdDateStrWithDate:(NSDate *)date;
+ (NSString *)createdDateShortStrWithDate:(NSDate *)date;

+ (NSString *)secondsWithCount:(int)count;
+ (NSString *)minutesWithCount:(int)count;
+ (NSString *)hoursWithCount:(int)count;
+ (NSString *)daysWithCount:(int)count;

@end
