//
//  NSObject+APL.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "NSObject+APL.h"

@implementation NSObject (APL)

- (BOOL)isString
{
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)isNumber
{
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)isNull
{
    return [self isKindOfClass:[NSNull class]];
}

@end
