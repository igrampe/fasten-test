//
//  FTSocketMessage.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 30/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTSocketMessage.h"

@implementation FTSocketMessage

- (NSString *)stringRepresentation
{
    NSString *representation = nil;
    
    NSDictionary *dict = [EKSerializer serializeObject:self withMapping:[[self class] objectMapping]];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    if (data)
    {
        representation = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return representation;
}

+ (instancetype)objectFromStringRepresentation:(NSString *)representation
{
    FTSocketMessage *message = nil;
    
    NSData *messageData = [representation dataUsingEncoding:NSUTF8StringEncoding];
    if (messageData)
    {
        NSDictionary *messageDict = [NSJSONSerialization JSONObjectWithData:messageData options:0 error:nil];
        if (messageDict)
        {
            message = [EKMapper objectFromExternalRepresentation:messageDict withMapping:[[self class] objectMapping]];
        }
    }
    
    return message;
}

#pragma mark - EKMappingProtocol

+ (EKObjectMapping *)objectMapping
{
    EKObjectMapping *mapping = [EKObjectMapping mappingForClass:[self class]
                                                      withBlock:
    ^(EKObjectMapping *mapping)
    {
        [mapping mapPropertiesFromArray:@[NSStringFromSelector(@selector(type)),
                                          NSStringFromSelector(@selector(sequence_id)),
                                          NSStringFromSelector(@selector(data))]];
    }];
    return mapping;
}

@end
