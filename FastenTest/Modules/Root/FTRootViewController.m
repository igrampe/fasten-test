//
//  FTRootViewController.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTRootViewController.h"

#import "FTRootViewOutput.h"

@interface FTRootViewController ()

@end

@implementation FTRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

@end
