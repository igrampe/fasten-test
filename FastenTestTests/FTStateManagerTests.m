//
//  FastenTestTests.m
//  FastenTestTests
//
//  Created by Semyon Belokovsky on 06/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <UICKeyChainStore.h>
#import "FTStateManager.h"

@interface FTStateManagerTests : XCTestCase

@property (nonatomic, strong) NSString *apiToken;

@end

@implementation FTStateManagerTests

- (void)setUp
{
    [super setUp];
    self.apiToken = @"api_token";
    [self resetKeychain];
    [self resetUserDefaults];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialize
{
    // When
    FTStateManager *stateManager1 = [FTStateManager new];
    
    // Then
    XCTAssertNotNil(stateManager1);
}

- (void)testShouldSetApiToken
{
    // Given
    NSDate *date = [self tokenExpirationDateWithExpired:NO];
    
    FTStateManager *stateManager1 = [FTStateManager new];
    
    // When
    [stateManager1 setApiToken:self.apiToken withExpirationDate:date];
    
    // Then
    XCTAssertEqualObjects(stateManager1.apiToken, self.apiToken);
    XCTAssertEqualObjects(stateManager1.apiTokenExpirationDate, date);
}

- (void)testShouldResetApiToken
{
    // Given
    NSDate *date = [self tokenExpirationDateWithExpired:NO];
    
    FTStateManager *stateManager1 = [FTStateManager new];
    [stateManager1 setApiToken:self.apiToken withExpirationDate:date];
    
    // When
    [stateManager1 resetApiToken];
    
    // Then
    XCTAssertNil(stateManager1.apiToken);
    XCTAssertNil(stateManager1.apiTokenExpirationDate);
}

- (void)testShouldSaveApiToken
{
    // Given
    NSDate *date = [self tokenExpirationDateWithExpired:NO];
    
    FTStateManager *stateManager1 = [FTStateManager new];
    [stateManager1 setApiToken:self.apiToken withExpirationDate:date];
    
    // When
    FTStateManager *stateManager2 = [FTStateManager new];
    
    // Then
    XCTAssertEqualObjects(stateManager2.apiToken, self.apiToken);
    XCTAssertEqualObjects(stateManager2.apiTokenExpirationDate, date);
}

- (void)testShouldResetExpiredToken
{
    // Given
    NSDate *date = [self tokenExpirationDateWithExpired:YES];
    
    FTStateManager *stateManager1 = [FTStateManager new];
    [stateManager1 setApiToken:self.apiToken withExpirationDate:date];
    
    // When
    FTStateManager *stateManager2 = [FTStateManager new];
    
    // Then
    XCTAssertNil(stateManager2.apiToken);
    XCTAssertNil(stateManager2.apiTokenExpirationDate);
}

- (void)testShouldReturnInitiallyAuthorizedFalse
{
    // Given
    FTStateManager *stateManager1 = [FTStateManager new];
    
    // Then
    XCTAssertFalse([stateManager1 isAuthorized]);
}

- (void)testShouldReturnAuthorizedTrueWithNotExpiredToken
{
    // Given
    FTStateManager *stateManager1 = [FTStateManager new];
    NSDate *date = [self tokenExpirationDateWithExpired:NO];
    
    // When
    [stateManager1 setApiToken:self.apiToken withExpirationDate:date];
    
    // Then
    XCTAssertTrue([stateManager1 isAuthorized]);
}

- (void)testShouldReturnAuthorizedFalseWithExpiredToken
{
    // Given
    FTStateManager *stateManager1 = [FTStateManager new];
    NSDate *date = [self tokenExpirationDateWithExpired:YES];
    
    // When
    [stateManager1 setApiToken:self.apiToken withExpirationDate:date];
    
    // Then
    XCTAssertFalse([stateManager1 isAuthorized]);
}

#pragma mark - Helpers

- (NSDate *)tokenExpirationDateWithExpired:(BOOL)expired
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:expired?-1000:1000];
    return date;
}

- (void)resetKeychain
{
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:[NSBundle mainBundle].bundleIdentifier];
    [keychain removeAllItems];
}

- (void)resetUserDefaults
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
