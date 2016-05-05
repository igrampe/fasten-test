//
//  FTSocketManager.h
//  FastenTest
//
//  Created by Semyon Belokovsky on 30/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTSocketMessage;

typedef void(^FTSocketMessageHandler)(FTSocketMessage *incomingMessage);

@interface FTSocketManager : NSObject

- (void)openConnection;
- (void)closeConnection;

- (void)sendMessage:(FTSocketMessage *)message withHandler:(FTSocketMessageHandler)handler;

@end
