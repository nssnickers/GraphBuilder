//
//  ValidatorTests.m
//  GraphBuilderTests
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Validator.h"
#import "FunctionValidationRule.h"

@interface ValidatorTests : XCTestCase

@property (strong, nonatomic) Validator *validator;
@property (strong, nonatomic) FunctionValidationRule *rule;

@end

@implementation ValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.validator = [[Validator alloc] init];
    self.rule = [[FunctionValidationRule alloc] initWithErrorMessage:@"error"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.validator = nil;
    self.rule = nil;
    [super tearDown];
}

- (void)testThatItInvokeSuccessBlock {
    //given
    NSString *function = @"x";
    BOOL __block successBlockInvoked = NO;
    BOOL __block failureBlockInvoked = NO;
    XCTestExpectation *expectationSuccess = [self expectationWithDescription:@"expect invoke success block"];
    
    //when
    [self.validator validateString:function withRule:self.rule validationSuccessful:^{
        successBlockInvoked = YES;
        [expectationSuccess fulfill];
    } validationFailure:^(NSString *error) {
        failureBlockInvoked = YES;
        [expectationSuccess fulfill];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.5 handler:^(NSError * _Nullable error) {
        XCTAssertTrue(successBlockInvoked);
        XCTAssertFalse(failureBlockInvoked);
    }];
}

- (void)testThatItInvokeFailureBlock {
    //given
    NSString *function = @"not function at all";
    BOOL __block successBlockInvoked = NO;
    BOOL __block failureBlockInvoked = NO;
    XCTestExpectation *expectationFail = [self expectationWithDescription:@"expect invoke fail block"];
    
    //when
    [self.validator validateString:function withRule:self.rule validationSuccessful:^{
        successBlockInvoked = YES;
        [expectationFail fulfill];
    } validationFailure:^(NSString *error) {
        failureBlockInvoked = YES;
        [expectationFail fulfill];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.5 handler:^(NSError * _Nullable error) {
        XCTAssertFalse(successBlockInvoked);
        XCTAssertTrue(failureBlockInvoked);
    }];
}

@end
