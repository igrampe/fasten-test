//
//  APLColorScheme.m
//  Client
//
//  Created by Semyon Belokovsky on 17/11/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLColorScheme.h"
#import "UIColor+APL.h"

@interface APLColorScheme ()

@property (nonatomic, strong) NSMutableDictionary *colors;

@end

@implementation APLColorScheme

+ (instancetype)sharedObject
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.colors = [NSMutableDictionary new];
    }
    return self;
}

- (void)registerColor:(UIColor *)color forName:(NSString *)name
{
    if (color && name)
    {
        [self.colors setObject:color forKey:name];
    }
}

- (void)registerColorWithHex:(NSString *)hex forName:(NSString *)name
{
    if (hex)
    {
        [self registerColor:UIColorWithHex(hex) forName:name];
    }
}

- (UIColor *)colorWithName:(NSString *)name
{
    UIColor *color = [self.colors objectForKey:name];
    return color;
}

+ (void)registerColorWithHex:(NSString *)hex forName:(NSString *)name
{    
    [[self sharedObject] registerColorWithHex:hex forName:name];
}

+ (UIColor *)colorWithName:(NSString *)name
{
    return [[self sharedObject] colorWithName:name];
}

UIColor* UIColorWithName(NSString *name)
{
    return [APLColorScheme colorWithName:name];
}

+ (NSString *)pathToColorScheme
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ColorScheme" ofType:@"plist"];
    return path;
}

+ (void)registerColorScheme
{    
    NSDictionary *colorScheme = [NSDictionary dictionaryWithContentsOfFile:[self pathToColorScheme]];
    for (NSString *name in [colorScheme allKeys])
    {
        NSString *hex = [colorScheme objectForKey:name];
        [self registerColorWithHex:hex forName:name];
    }
}

@end
