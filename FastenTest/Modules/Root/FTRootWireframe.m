//
//  FTRootWireframe.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTRootWireframe.h"
#import "FTRootViewController.h"
#import "FTRootViewOutput.h"

#import "APLBlocks.h"
#import "FTServiceLocator.h"
#import "FTStateManager.h"

#import "FTAuthWireframe.h"
#import "FTStatusWireframe.h"

@interface FTRootWireframe () <FTRootViewOutput, FTAuthWireframeOutput>

@property (nonatomic, strong) FTRootViewController *userInterface;

@property (nonatomic, strong) FTAuthWireframe *authWireframe;
@property (nonatomic, strong) FTStatusWireframe *statusWireframe;

@end

@implementation FTRootWireframe

@synthesize serviceLocator;

#pragma mark - FTWireFrameProtocol

- (void)presentViewFromWindow:(UIWindow *)fromWindow
{
    self.userInterface = [FTRootViewController createVC];
    self.userInterface.output = self;
    
    APLDispatchBlockToMainQueue(
    ^
    {
        fromWindow.rootViewController = self.userInterface;
    });
}

#pragma mark - FTRootViewOutput

- (void)viewWillAppear
{
    if ([self.serviceLocator.stateManager isAuthorized])
    {
        [self _presentStatusWithSuccessMessage:NO];
    } else
    {
        [self _presentSignIn];
    }
}

#pragma mark - Private

- (void)_presentSignIn
{
    self.authWireframe = [FTAuthWireframe new];
    self.authWireframe.serviceLocator = self.serviceLocator;
    self.authWireframe.output = self;
    if ([self.authWireframe respondsToSelector:@selector(presentViewFromViewController:)])
    {
        [self.authWireframe presentViewFromViewController:self.userInterface];
    }
}

- (void)_presentStatusWithSuccessMessage:(BOOL)successMessage
{
    self.statusWireframe = [FTStatusWireframe new];
    self.statusWireframe.shouldShowSignInMessage = successMessage;
    self.statusWireframe.serviceLocator = self.serviceLocator;
    if ([self.statusWireframe respondsToSelector:@selector(presentViewFromViewController:)])
    {
        [self.statusWireframe presentViewFromViewController:self.userInterface];
    }
}

#pragma mark - FTAuthWireframeOutput

- (void)authWireframeDidFinish:(FTAuthWireframe *)wireframe
{
    if ([wireframe respondsToSelector:@selector(dismiss)])
    {
        [wireframe dismiss];
    }
    if (self.authWireframe == wireframe)
    {
        self.authWireframe = nil;
    }
    [self _presentStatusWithSuccessMessage:YES];
}

@end
