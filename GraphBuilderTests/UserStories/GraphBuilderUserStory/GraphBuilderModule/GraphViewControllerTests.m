//
//  GraphViewControllerTests.m
//  GraphBuilderTests
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GraphViewController.h"
#import "GraphPresenterProtocol.h"
#import "GraphViewController+testable.h"

@interface GraphViewControllerTests : XCTestCase

@property (strong, nonatomic) GraphViewController *view;
@property (strong, nonatomic) id presenterMock;

@end

@implementation GraphViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.view = [GraphViewController new];
    self.presenterMock = OCMProtocolMock(@protocol(GraphPresenterProtocol));
    self.view.presenter = self.presenterMock;
}

- (void)tearDown {
    self.view = nil;
    [self.presenterMock stopMocking];
    self.presenterMock = nil;
    
    [super tearDown];
}

- (void)testSuccessDidTapShareButton {
    // when
    [self.view didTapBuildButton:nil];
    
    // then
    OCMVerify([self.presenterMock buildButtonClicked]);
}

@end
