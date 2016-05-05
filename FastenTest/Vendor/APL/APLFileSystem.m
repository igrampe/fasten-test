//
//  APLFileSystem.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLFileSystem.h"

@implementation APLFileSystem

+ (NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths.firstObject;
    return path;
}

+ (NSString *)documentsPathWidthSubPath:(NSString *)subPath {
    NSString *path = [self documentsPath];
    path = [path stringByAppendingPathComponent:subPath];
    return path;
}

+ (BOOL)fileExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)fileExistsAtDocumentsSubPath:(NSString *)subPath {
    NSString *path = [self documentsPath];
    path = [path stringByAppendingPathComponent:subPath];
    return  [self fileExistsAtPath:path];
}

@end
