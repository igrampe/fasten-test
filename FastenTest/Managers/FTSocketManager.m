//
//  FTSocketManager.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 30/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTSocketManager.h"

#import <SRWebSocket.h>

#import "Constants.h"

#import "FTSocketMessage.h"

NSInteger const FTSocketManagerRecconectTimeout = 10;

@interface FTSocketManager () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socket;
@property (nonatomic, strong) NSMutableArray *outgoingQueue;
@property (nonatomic, strong) NSMutableDictionary *handlersTable;

@end

@implementation FTSocketManager

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSURL *url = [NSURL URLWithString:WS_PATH];
        if (url)
        {
            self.socket = [[SRWebSocket alloc] initWithURL:url];
            self.socket.delegate = self;
            self.handlersTable = [NSMutableDictionary new];
        }
        NSAssert(self.socket, @"WebSocket should be initialized");
        self.outgoingQueue = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Public

- (void)openConnection
{
    [self.socket open];
}

- (void)closeConnection
{
    [self.socket close];
}

- (void)sendMessage:(FTSocketMessage *)message withHandler:(FTSocketMessageHandler)handler
{
    NSString *msgStr = [message stringRepresentation];
    if (msgStr)
    {
        [self.handlersTable setObject:[handler copy] forKey:message.sequence_id];
        [self.outgoingQueue addObject:msgStr];
        [self _dequeue];
    }
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    if ([message isKindOfClass:[NSString class]])
    {
        NSString *msgStr = (NSString *)message;
        FTSocketMessage *msg = [FTSocketMessage objectFromStringRepresentation:msgStr];
        [self _perfromHandlerForMessage:msg];
        [self _releaseHandlerWithUUID:msg.sequence_id];
    }
    [self _dequeue];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    [self _dequeue];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    [self _tryToReconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason
         wasClean:(BOOL)wasClean
{
    [self _tryToReconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    
}

#pragma mark - Private

- (void)_dequeue
{
    if (self.socket.readyState == SR_OPEN)
    {
        if (self.outgoingQueue.count > 0)
        {
            NSString *message = [self.outgoingQueue firstObject];
            [self.outgoingQueue removeObjectAtIndex:0];
            [self.socket send:message];
        }
    }
}

- (void)_releaseHandlerWithUUID:(NSString *)uuid
{
    if (uuid)
    {
        [self.handlersTable removeObjectForKey:uuid];
    }
}

- (void)_perfromHandlerForMessage:(FTSocketMessage *)message
{
    NSString *uuid = message.sequence_id;
    if (uuid)
    {
        FTSocketMessageHandler handler = [self.handlersTable objectForKey:uuid];
        if (handler)
        {
            handler(message);
        }
    }
}

- (void)_tryToReconnect
{
    [self performSelector:@selector(openConnection) withObject:nil afterDelay:FTSocketManagerRecconectTimeout];
}

@end
