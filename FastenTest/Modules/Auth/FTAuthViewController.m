//
//  FTAuthViewController.m
//  FastenTest
//
//  Created by Semyon Belokovsky on 29/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "FTAuthViewController.h"
#import "FTAuthViewOutput.h"

#import <PureLayout.h>
#import "APLColorScheme.h"
#import "APLKeyboardHelper.h"
#import "NSNotificationCenter+APL.h"

#import "FTTextField.h"
#import "FTRoundedButton.h"
#import "FTErrorView.h"

@interface FTAuthViewController () <UITextFieldDelegate>

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL hasKeyboard;

@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, strong) FTErrorView *errorView;
@property (nonatomic, strong) NSLayoutConstraint *errorViewContraintTop;

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) FTTextField *emailField;
@property (nonatomic, strong) FTTextField *passwordField;
@property (nonatomic, strong) FTRoundedButton *signInButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, assign) BOOL needShowError;

@end

@implementation FTAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = APLCSC(Color_White);
    
    self.contentView = [UIScrollView newAutoLayoutView];
    [self.view addSubview:self.contentView];
    
    self.emailField = [FTTextField newAutoLayoutView];
    self.emailField.textField.delegate = self;
    self.emailField.textField.placeholder = NSLS(@"Email");
    [self.contentView addSubview:self.emailField];
    
    self.passwordField = [FTTextField newAutoLayoutView];
    self.passwordField.textField.delegate = self;
    self.passwordField.textField.placeholder = NSLS(@"Password");
    self.passwordField.textField.secureTextEntry = YES;
    [self.contentView addSubview:self.passwordField];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.hidesWhenStopped = YES;
    [self.contentView addSubview:self.activityView];
    
    self.signInButton = [FTRoundedButton newAutoLayoutView];
    [self.signInButton setTitle:NSLS(@"Sign in") forState:UIControlStateNormal];
    self.signInButton.backgroundColor = APLCSC(Color_Orange);
    [self.signInButton addTarget:self.output
                          action:@selector(actionSignIn)
                forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.signInButton];
    
    self.errorView = [FTErrorView newAutoLayoutView];
    [self.view addSubview:self.errorView];
    
    [self setupKeyboardHandling];
}

- (void)setupKeyboardHandling
{
    __weak typeof(self) welf = self;
    [self handleKeyboardWillShow:^(CGSize keyboardSize, double duration)
     {
         welf.hasKeyboard = YES;
         [welf _handleKeyboardWithHeight:keyboardSize.height];
     }];
    
    [self handleKeyboardWillHide:^(CGSize keyboardSize, double duration)
     {
         welf.hasKeyboard = NO;
         [welf _handleKeyboardWithHeight:keyboardSize.height];
     }];
    
    [self handleKeyboardWillChange:
     ^(CGSize keyboardSize, double duration)
     {
         [welf _handleKeyboardWithHeight:keyboardSize.height];
     }];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (!self.didSetupConstraints)
    {
        [self.contentView autoPinEdgesToSuperviewEdges];
        
        [self.emailField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
        [self.emailField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [self.emailField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:-[self.emailField height]-8];
        [self.emailField autoSetDimension:ALDimensionHeight toSize:[self.emailField height]];
        [self.emailField autoSetDimension:ALDimensionWidth
                                   toSize:(MAIN_SCREEN.bounds.size.width-32)
                                 relation:NSLayoutRelationGreaterThanOrEqual];
        
        [self.passwordField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.emailField];
        [self.passwordField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.emailField];
        [self.passwordField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.emailField withOffset:16];
        [self.passwordField autoSetDimension:ALDimensionHeight toSize:[self.passwordField height]];
        
        [self.signInButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
        [self.signInButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
        [self.signInButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.passwordField withOffset:16];
        [self.signInButton autoSetDimension:ALDimensionHeight toSize:44];
        [self.signInButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [self.activityView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.signInButton];
        [self.activityView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.signInButton];
        
        [self.errorView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.errorView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        
        self.didSetupConstraints = YES;
    }
    
    [self.errorViewContraintTop autoRemove];
    if (self.needShowError)
    {
        self.errorViewContraintTop = [self.errorView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    } else
    {
        self.errorViewContraintTop = [self.errorView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.view];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - FTAuthViewInput

- (void)showLoader
{
    self.emailField.textField.userInteractionEnabled = NO;
    self.passwordField.textField.userInteractionEnabled = NO;
    [self.activityView startAnimating];
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:0.25
                     animations:^
    {
        welf.signInButton.alpha = 0;
    }];
}

- (void)hideLoader
{
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:0.25
                     animations:
     ^
    {
        welf.signInButton.alpha = 1;
    } completion:
     ^(BOOL finished)
    {
        welf.emailField.textField.userInteractionEnabled = YES;
        welf.passwordField.textField.userInteractionEnabled = YES;
        [welf.activityView stopAnimating];
    }];
}

- (void)showErrorWithMessage:(NSString *)message
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    self.errorView.textlabel.text = message;
    self.needShowError = YES;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:0.25
                     animations:
     ^
     {
         [welf.view layoutIfNeeded];
     }];
}

- (void)hideError
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.needShowError = NO;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:0.25
                     animations:
     ^
    {
        [welf.view layoutIfNeeded];
    }];
}

- (void)deactivateTextField
{
    [self.activeTextField resignFirstResponder];
}

- (NSString *)valueEmail
{
    return self.emailField.textField.text;
}

- (NSString *)valuePassword
{
    return self.passwordField.textField.text;
}

#pragma mark - Private

- (void)_handleKeyboardWithHeight:(CGFloat)keyboardHeight
{
    CGFloat insetBottom = 0;
    if (self.hasKeyboard)
    {
        insetBottom = keyboardHeight + 16;
    }
    self.contentView.contentInset = UIEdgeInsetsMake(0, 0, insetBottom, 0);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}

@end
