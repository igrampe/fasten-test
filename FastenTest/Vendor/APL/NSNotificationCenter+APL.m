//
//  NSNotificationCenter+APL.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "NSNotificationCenter+APL.h"

@implementation NSObject (Notifications)

- (void)observeNotification:(NSString *)notificationName
               withSelector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:notificationName object:nil];
}

@end

@implementation NSNotificationCenter (APL)

void NSNCPost(NSString *notificationName, id object)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object];
}

@end
