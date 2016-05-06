//
//  FTStatusWireframe.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 06/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTStatusWireframe.h"
#import "FTStatusViewController.h"
#import "FTStatusViewOutput.h"

#import "APLBlocks.h"
#import "FTServiceLocator.h"
#import "FTStateManager.h"

@interface FTStatusWireframe () <FTStatusViewOutput>

@property (nonatomic, strong) FTStatusViewController *userInterface;

@end

@implementation FTStatusWireframe

@synthesize serviceLocator;

#pragma mark - FTWireframeProtocol

- (void)presentViewFromViewController:(UIViewController *)fromVC
{
    self.userInterface = [FTStatusViewController createVC];
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

#pragma mark - FTStatusViewOutput

- (void)viewWillAppear
{
    [self _showExpirationDate];
    if (self.shouldShowSignInMessage)
    {
        [self _showSuccessMessage];
    }
}

#pragma mark - Private

- (void)_showExpirationDate
{
    NSDate *date = [self.serviceLocator.stateManager apiTokenExpirationDate];
    if (date)
    {
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"dd MMM yyyy HH:mm"];
        [self.userInterface showExpirationDate:[formatter stringFromDate:date]];
    }
}

- (void)_showSuccessMessage
{
    [self.userInterface showNotice:NSLS(@"Success authentication")];
}

@end
