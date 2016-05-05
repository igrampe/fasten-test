//
//  FTSocketMessage.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 30/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping.h>

@interface FTSocketMessage : NSObject <EKMappingProtocol>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sequence_id;
@property (nonatomic, strong) NSDictionary *data;

- (NSString *)stringRepresentation;
+ (instancetype)objectFromStringRepresentation:(NSString *)representation;

@end
