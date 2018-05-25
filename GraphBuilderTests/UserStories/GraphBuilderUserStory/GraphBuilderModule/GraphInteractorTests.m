//
//  GraphInteractorTests.m
//  GraphBuilderTests
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "GraphInteractor.h"
#import "GraphPresenterProtocol.h"

@interface GraphInteractorTests : XCTestCase

@property (strong, nonatomic) GraphInteractor *interactor;
@property (strong, nonatomic) id mockPresenter;

@end

@implementation GraphInteractorTests

- (void)setUp {
    [super setUp];
    
    self.mockPresenter = OCMProtocolMock(@protocol(GraphPresenterProtocol));
    self.interactor = [GraphInteractor new];
    self.interactor.presenter = self.mockPresenter;
}

- (void)tearDown {
    [self.mockPresenter stopMocking];
    self.mockPresenter = nil;
    self.interactor = nil;
    
    [super tearDown];
}

- (void)testThatItInvokeSuccessBlock {
    //given
    NSString *function = @"x";
    BOOL __block successBlockInvoked = NO;
    BOOL __block failureBlockInvoked = NO;
    XCTestExpectation *expectationSuccess = [self expectationWithDescription:@"expect invoke success block"];
    
    //when
    [self.interactor validateFunction:function success:^{
        successBlockInvoked = YES;
        [expectationSuccess fulfill];
    } failure:^(NSString *title, NSString *message) {
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
    [self.interactor validateFunction:function success:^{
        successBlockInvoked = YES;
        [expectationFail fulfill];
    } failure:^(NSString *title, NSString *message) {
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
