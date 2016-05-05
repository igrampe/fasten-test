//
//  FTStateManager.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 04/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTStateManager.h"

#import <UICKeyChainStore.h>

NSString *const kFTStateManagerKeyLaunchCount = @"kFTStateManagerKeyLaunchCount";

NSString *const kFTStateManagerKeyApiToken = @"kFTStateManagerKeyApiToken";
NSString *const kFTStateManagerKeyApiTokenExpiration = @"kFTStateManagerKeyApiTokenExpiration";

@interface FTStateManager ()

@property (nonatomic, strong) UICKeyChainStore *keychain;

@property (nonatomic, strong, readwrite) NSString *apiToken;
@property (nonatomic, strong, readwrite) NSDate *apiTokenExpirationDate;

@end

@implementation FTStateManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.keychain = [UICKeyChainStore keyChainStoreWithService:[NSBundle mainBundle].bundleIdentifier];
        
        NSInteger launchCount = [USER_DEFAULTS integerForKey:kFTStateManagerKeyLaunchCount];
        launchCount++;
        [USER_DEFAULTS setInteger:launchCount forKey:kFTStateManagerKeyLaunchCount];
        [USER_DEFAULTS synchronize];
        
        if (launchCount == 1)
        {
            [self.keychain removeAllItems];
        }
        
        _apiToken = self.keychain[kFTStateManagerKeyApiToken];
        NSData *data = [self.keychain dataForKey:kFTStateManagerKeyApiTokenExpiration];
        if (data)
        {
            _apiTokenExpirationDate = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        
        if ([_apiTokenExpirationDate timeIntervalSinceDate:[NSDate date]] <= 0)
        {
            [self resetApiToken];
        }
    }
    return self;
}

#pragma mark - Public

- (void)setApiToken:(NSString *)apiToken withExpirationDate:(NSDate *)expirationDate
{
    self.apiToken = apiToken;
    self.apiTokenExpirationDate = expirationDate;
}

- (void)resetApiToken
{
    [self setApiToken:nil withExpirationDate:nil];
}

- (BOOL)isAuthorized
{
    BOOL result = NO;
    
    if (self.apiToken)
    {
        if ([_apiTokenExpirationDate timeIntervalSinceDate:[NSDate date]] > 0)
        {
            result = YES;
        } else
        {
            [self resetApiToken];
        }
    }
    
    return result;
}

#pragma mark - Setters

- (void)setApiToken:(NSString *)apiToken
{
    _apiToken = apiToken;
    self.keychain[kFTStateManagerKeyApiToken] = _apiToken;
}

- (void)setApiTokenExpirationDate:(NSDate *)apiTokenExpirationDate
{
    _apiTokenExpirationDate = apiTokenExpirationDate;
    if (_apiTokenExpirationDate)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_apiTokenExpirationDate];
        [self.keychain setData:data forKey:kFTStateManagerKeyApiTokenExpiration];
    } else
    {
        [self.keychain removeItemForKey:kFTStateManagerKeyApiTokenExpiration];
    }
}

@end
