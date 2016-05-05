//
//  NSString+Utils.h
//  Client
//
//  Created by Semyon Belokovsky on 10/12/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, URLQueryOptions)
{
    //mutually exclusive
    URLQueryOptionDefault = 0,
    URLQueryOptionKeepLastValue,
    URLQueryOptionKeepFirstValue,
    URLQueryOptionUseArrays,
    URLQueryOptionAlwaysUseArrays,
    
    //can be |ed with other values
    URLQueryOptionUseArraySyntax = 8,
    URLQueryOptionSortKeys = 16
};

static NSString *const URLSchemeComponent = @"scheme";
static NSString *const URLHostComponent = @"host";
static NSString *const URLPortComponent = @"port";
static NSString *const URLUserComponent = @"user";
static NSString *const URLPasswordComponent = @"password";
static NSString *const URLPathComponent = @"path";
static NSString *const URLParameterStringComponent = @"parameterString";
static NSString *const URLQueryComponent = @"query";
static NSString *const URLFragmentComponent = @"fragment";

@interface NSString (RequestUtils)

#pragma mark URLEncoding

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString:(BOOL)decodePlusAsSpace;

#pragma mark URL path extension

- (NSString *)stringByAppendingURLPathExtension:(NSString *)extension;
- (NSString *)stringByDeletingURLPathExtension;
- (NSString *)URLPathExtension;

#pragma mark URL paths

- (NSString *)stringByAppendingURLPathComponent:(NSString *)str;
- (NSString *)stringByDeletingLastURLPathComponent;
- (NSString *)lastURLPathComponent;

#pragma mark URL query

+ (NSString *)URLQueryWithParameters:(NSDictionary *)parameters;
+ (NSString *)URLQueryWithParameters:(NSDictionary *)parameters options:(URLQueryOptions)options;

- (NSString *)URLQuery;
- (NSString *)stringByDeletingURLQuery;
- (NSString *)stringByReplacingURLQueryWithQuery:(NSString *)query;
- (NSString *)stringByAppendingURLQuery:(NSString *)query;
- (NSString *)stringByMergingURLQuery:(NSString *)query;
- (NSString *)stringByMergingURLQuery:(NSString *)query options:(URLQueryOptions)options;
- (NSDictionary *)URLQueryParameters;
- (NSDictionary *)URLQueryParametersWithOptions:(URLQueryOptions)options;

#pragma mark URL fragment ID

- (NSString *)URLFragment;
- (NSString *)stringByDeletingURLFragment;
- (NSString *)stringByAppendingURLFragment:(NSString *)fragment;

#pragma mark URL conversion

- (NSURL *)URLValue;
- (NSURL *)URLValueRelativeToURL:(NSURL *)baseURL;

#pragma mark base 64

- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;

@end


@interface NSURL (RequestUtils)

+ (instancetype)URLWithComponents:(NSDictionary *)components;
- (NSDictionary *)components;

- (NSURL *)URLWithScheme:(NSString *)scheme;
- (NSURL *)URLWithHost:(NSString *)host;
- (NSURL *)URLWithPort:(NSString *)port;
- (NSURL *)URLWithUser:(NSString *)user;
- (NSURL *)URLWithPassword:(NSString *)password;
- (NSURL *)URLWithPath:(NSString *)path;
- (NSURL *)URLWithParameterString:(NSString *)parameterString;
- (NSURL *)URLWithQuery:(NSString *)query;
- (NSURL *)URLWithFragment:(NSString *)fragment;

@end


@interface NSURLRequest (RequestUtils)

+ (instancetype)HTTPRequestWithURL:(NSURL *)URL method:(NSString *)method parameters:(NSDictionary *)parameters;
+ (instancetype)GETRequestWithURL:(NSURL *)URL parameters:(NSDictionary *)parameters;
+ (instancetype)POSTRequestWithURL:(NSURL *)URL parameters:(NSDictionary *)parameters;

- (NSDictionary *)GETParameters;
- (NSDictionary *)POSTParameters;
- (NSString *)HTTPBasicAuthUser;
- (NSString *)HTTPBasicAuthPassword;

@end


@interface NSMutableURLRequest (RequestUtils)

- (void)setGETParameters:(NSDictionary *)parameters;
- (void)setGETParameters:(NSDictionary *)parameters options:(URLQueryOptions)options;
- (void)addGETParameters:(NSDictionary *)parameters options:(URLQueryOptions)options;
- (void)setPOSTParameters:(NSDictionary *)parameters;
- (void)setPOSTParameters:(NSDictionary *)parameters options:(URLQueryOptions)options;
- (void)addPOSTParameters:(NSDictionary *)parameters options:(URLQueryOptions)options;
- (void)setHTTPBasicAuthUser:(NSString *)user password:(NSString *)password;

@end
