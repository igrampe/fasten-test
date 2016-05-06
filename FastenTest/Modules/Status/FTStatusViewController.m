//
//  FTStatusViewController.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 06/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTStatusViewController.h"
#import "FTStatusViewOutput.h"

#import "APLColorScheme.h"

#import <PureLayout.h>

@interface FTStatusViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *tokenLabel;
@property (nonatomic, strong) UILabel *expirationDateLabel;

@end

@implementation FTStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

- (void)setupView
{
    self.view.backgroundColor = APLCSC(Color_White);
    self.noticeLabel = [UILabel new];
    self.noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.noticeLabel];
    
    self.expirationDateLabel = [UILabel new];
    self.expirationDateLabel.textAlignment = NSTextAlignmentCenter;
    self.expirationDateLabel.numberOfLines = 0;
    [self.view addSubview:self.expirationDateLabel];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (!self.didSetupConstraints)
    {
        [self.expirationDateLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.expirationDateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
        [self.expirationDateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        
        [self.noticeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
        [self.noticeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [self.noticeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.expirationDateLabel withOffset:-16];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - FTStatusViewInput

- (void)showExpirationDate:(NSString *)dateString
{
    NSString *text = [NSString stringWithFormat:@"%@\n%@", NSLS(@"Expiration time"), dateString];
    self.expirationDateLabel.text = text;
    
    [self.view setNeedsUpdateConstraints];
    [self.view setNeedsLayout];
}

- (void)showNotice:(NSString *)notice
{
    self.noticeLabel.hidden = notice?NO:YES;
    self.noticeLabel.text = notice;
    
    [self.view setNeedsUpdateConstraints];
    [self.view setNeedsLayout];
}

@end
