//
//  APLFileSystem.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APLFileSystem : NSObject

+ (NSString *)documentsPath;
+ (NSString *)documentsPathWidthSubPath:(NSString *)subPath;

+ (BOOL)fileExistsAtPath:(NSString *)path;
+ (BOOL)fileExistsAtDocumentsSubPath:(NSString *)subPath;

@end
