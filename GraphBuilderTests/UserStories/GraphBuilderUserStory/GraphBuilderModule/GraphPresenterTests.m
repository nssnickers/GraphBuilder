//
//  GraphPresenterTests.m
//  GraphBuilderTests
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GraphPresenter.h"
#import "GraphInteractor.h"
#import "GraphViewProtocol.h"
#import "GraphData.h"

@interface GraphPresenterTests : XCTestCase

@property (strong, nonatomic) GraphPresenter *presenter;
@property (strong, nonatomic) GraphInteractor *interactor;
@property (strong, nonatomic) id mockView;
@property (strong, nonatomic) GraphData *graphData;

@end

@implementation GraphPresenterTests

- (void)setUp {
    [super setUp];
    
    self.mockView = OCMProtocolMock(@protocol(GraphViewProtocol));
    
    self.presenter = [GraphPresenter new];
    self.presenter.view = self.mockView;
    self.graphData = [[GraphData alloc] init];
    self.presenter.graphData = self.graphData;
    
    self.interactor = [GraphInteractor new];
    self.interactor.presenter = self.presenter;
    
    self.presenter.view = self.mockView;
    self.presenter.interactor = self.interactor;
}

- (void)tearDown {
    [self.mockView stopMocking];
    self.mockView = nil;
    self.presenter = nil;
    self.interactor = nil;
    self.graphData = nil;
    
    [super tearDown];
}

- (void)testThatConfigureView {
    //when
    [self.presenter configureView];
    
    //then
    OCMVerify([self.mockView setGraphViewDataSource:self.graphData]);
}

- (void)testThatItInvokeUpdateViewWithAcceptedFunction {
    //given
    OCMStub([self.mockView obtainFunctionText]).andReturn(@"x");
    
    //when
    [self.presenter buildButtonClicked];
    
    //then
    OCMVerify([self.mockView updateGraphView]);
}

- (void)testThatItInvokeAlertWithNotAcceptedFunction {
    //given
    OCMStub([self.mockView obtainFunctionText]).andReturn(@"xxxx");
    
    
    //when
    [self.presenter buildButtonClicked];
    
    //then
    OCMVerify([self.mockView showAlertWithTitle:@"" message:@"В поле ввода могут быть введены только положительные числа, круглые скобки, операции '+', '-', '*', символ 'x', символ пробел."]);
}

@end
