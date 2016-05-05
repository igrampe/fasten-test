//
//  NSDate+Helpers.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 05/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "NSDate+Helpers.h"

@implementation NSDate (Helpers)

+ (NSDate *)ft_dateFromString:(NSString *)string
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *expirationDate = [formatter dateFromString:string];
    return expirationDate;
}

@end
