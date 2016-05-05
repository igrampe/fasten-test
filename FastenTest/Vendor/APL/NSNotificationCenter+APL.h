//
//  NSNotificationCenter+APL.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Notifications)

- (void)observeNotification:(NSString *)notificationName
               withSelector:(SEL)selector;

@end

@interface NSNotificationCenter (APL)

void NSNCPost(NSString *notificationName, id object);

@end
