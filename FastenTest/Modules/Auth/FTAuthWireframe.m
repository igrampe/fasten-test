//
//  FTAuthWireframe.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTAuthWireframe.h"
#import "FTAuthViewController.h"
#import "FTAuthViewOutput.h"

#import <SHEmailValidator.h>

#import "APLBlocks.h"
#import "FTServiceLocator.h"
#import "FTApiManager.h"
#import "FTStateManager.h"

@interface FTAuthWireframe () <FTAuthViewOutput>

@property (nonatomic, strong) FTAuthViewController *userInterface;

@end

@implementation FTAuthWireframe

@synthesize serviceLocator;

#pragma mark - FTWireframeProtocol

- (void)presentViewFromViewController:(UIViewController *)fromVC
{
    self.userInterface = [FTAuthViewController createVC];
    self.userInterface.output = self;
    
    __weak typeof(self) welf = self;
    APLDispatchBlockToMainQueue(
    ^
    {
        welf.userInterface.view.frame = fromVC.view.bounds;
        [fromVC addChildViewController:welf.userInterface];
        [fromVC.view addSubview:welf.userInterface.view];
    });
}

- (void)dismiss
{
    [self.userInterface removeFromParentViewController];
    [self.userInterface.view removeFromSuperview];
}

#pragma mark - FTAuthViewOutput

- (void)viewWillAppear
{
//    [self.serviceLocator.apiManager signinWithEmail:@"fpi@bk.ru"
//                                           password:@"123123"
//                                            handler:
//    ^(NSString *apiToken, NSData *apiTokenExpiration, NSError *error)
//    {
//        
//    }];
}

- (void)actionSignIn
{
    [self.userInterface deactivateTextField];
    
    NSString *emailValue = [self.userInterface valueEmail];
    NSString *passwordValue = [self.userInterface valuePassword];
    
    NSString *errorMessage = nil;
    if (emailValue.length == 0)
    {
        errorMessage = NSLS(@"Enter email");
    }
    else if (![[SHEmailValidator validator] validateSyntaxOfEmailAddress:emailValue withError:nil])
    {
        errorMessage = NSLS(@"Enter valid email");
    } else if (passwordValue.length == 0)
    {
        errorMessage = NSLS(@"Enter password");
    }
    
    if (errorMessage)
    {
        [self _showErrorWithMessage:errorMessage];
    } else
    {
        [self.userInterface showLoader];
        __weak typeof(self) welf = self;
        [self.serviceLocator.apiManager signinWithEmail:emailValue
                                               password:passwordValue
                                                handler:
         ^(NSString *apiToken, NSDate *apiTokenExpiration, NSError *error)
        {
            [welf.userInterface hideLoader];
            if (error)
            {
                [welf _showErrorWithMessage:error.localizedDescription];
            } else
            {
                [welf.serviceLocator.stateManager setApiToken:apiToken withExpirationDate:apiTokenExpiration];
                [welf.output authWireframeDidFinish:welf];
            }
        }];
    }
}

#pragma mark - Private

- (void)_showErrorWithMessage:(NSString *)message
{
    NSTimeInterval showImterval = MAX((float)message.length * 0.06 + 0.5, 2);
    [self.userInterface showErrorWithMessage:message];
    [self.userInterface performSelector:@selector(hideError)
                             withObject:nil
                             afterDelay:showImterval];
}

@end
