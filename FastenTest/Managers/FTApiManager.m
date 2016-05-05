//
//  FTApiManager.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 04/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTApiManager.h"

#import "FTSocketManager.h"
#import "FTSocketMessage.h"

#import "NSDate+Helpers.h"

NSString *const FTApiManagerErrorDomain = @"FTApiManagerErrorDomain";

#pragma mark - Message Types

#pragma mark -- Out

NSString *const kFTApiMessageTypeOutLoginCustomer = @"LOGIN_CUSTOMER";

#pragma mark -- In

NSString *const kFTApiMessageTypeInCustomerError = @"CUSTOMER_ERROR";
NSString *const kFTApiMessageTypeInApiToken = @"CUSTOMER_API_TOKEN";

@interface FTApiManager ()

@property (nonatomic, strong) FTSocketManager *socketManager;

@end

@implementation FTApiManager

- (void)start
{
    [self.socketManager openConnection];
}

#pragma mark - Lazy

- (FTSocketManager *)socketManager
{
    if (!_socketManager)
    {
        _socketManager = [FTSocketManager new];
    }
    return _socketManager;
}

#pragma mark - Public

- (void)signinWithEmail:(NSString *)email password:(NSString *)password handler:(FTApiManagerSignInHandler)handler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (email)
    {
        params[@"email"] = email;
    }
    if (password)
    {
        params[@"password"] = password;
    }
    
    __weak typeof(self) welf = self;
    [self _sendSocketMessageWithType:kFTApiMessageTypeOutLoginCustomer
                                data:params
                             handler:
    ^(FTSocketMessage *incomingMessage)
    {
        if ([incomingMessage.type isEqualToString:kFTApiMessageTypeInApiToken])
        {
            NSString *apiToken = incomingMessage.data[@"api_token"];
            NSString *expirationDateStr = incomingMessage.data[@"api_token_expiration_date"];
            NSDate *expirationDate = [NSDate ft_dateFromString:expirationDateStr];
            
            if (handler)
            {
                handler(apiToken, expirationDate, nil);
            }
        } else
        {
            if (handler)
            {
                handler(nil, nil, [welf _errorFromIncomingMessage:incomingMessage]);
            }
        }
    }];
}

#pragma mark - Private

- (void)_sendSocketMessageWithType:(NSString *)type
                              data:(NSDictionary *)data
                           handler:(FTSocketMessageHandler)handler
{
    FTSocketMessage *message = [FTSocketMessage new];
    if (type)
    {
        message.type = type;
    }
    if (data)
    {
        message.data = data;
    }
    message.sequence_id = [[NSUUID UUID] UUIDString];// //@"a29e4fd0-581d-e06b-c837-4f5f4be7dd18";
    
    [self.socketManager sendMessage:message withHandler:handler];
}

- (NSError *)_errorFromIncomingMessage:(FTSocketMessage *)incomingMessage
{
    NSError *error = nil;
    
    NSString *errorMessage = incomingMessage.data[@"error_description"];
    NSString *errorCode = incomingMessage.data[@"error_code"];
    
    if (errorMessage && errorCode)
    {
        error = [[NSError alloc] initWithDomain:FTApiManagerErrorDomain
                                           code:0
                                       userInfo:@{@"NSLocalizedDescription":errorMessage}];
    } else
    {
        error = [[NSError alloc] initWithDomain:FTApiManagerErrorDomain
                                           code:-999
                                       userInfo:@{@"NSLocalizedDescription":NSLS(@"Unknown error")}];
    }
    
    return error;
}

@end
