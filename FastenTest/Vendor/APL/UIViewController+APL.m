//
//  UIViewController+APL.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "UIViewController+APL.h"

@implementation UIViewController (APL)

+ (instancetype)createVC
{
	Class class = [self class];
    
	id vc = [[class alloc] initWithNibName:nil bundle:nil];
	return vc;
}

+ (id)createVCWithXib
{
    Class class = [self class];
    NSString *className = NSStringFromClass(class);
    NSString *xibName = className;
    if (IS_IPAD)
    {
        xibName = [xibName stringByAppendingString:@"-iPad"];
    }
    id vc = [[class alloc] initWithNibName:xibName bundle:nil];
    return vc;
}

+ (id)createVCWithOneXib
{
    Class class = [self class];
    NSString *className = NSStringFromClass(class);
    NSString *xibName = className;
    id vc = [[class alloc] initWithNibName:xibName bundle:nil];
    return vc;
}

@end
