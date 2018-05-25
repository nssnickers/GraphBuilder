//
//  FunctionValidatorRuleTests.m
//  GraphBuilderTests
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FunctionValidationRule.h"

@interface FunctionValidatorRuleTests : XCTestCase

@property (strong, nonatomic) FunctionValidationRule *rule;

@end

@implementation FunctionValidatorRuleTests

- (void)setUp {
    [super setUp];
    
    self.rule = [[FunctionValidationRule alloc] initWithErrorMessage:@"error"];
}

- (void)tearDown {
    self.rule = nil;
    [super tearDown];
}

- (void)testItValidWhenStringContainAcceptedCharacters {
    //given
    NSString *stringForValidate = @"x*(x+4) - x*6 + 105";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertTrue(result);
}

- (void)testItNotValidWhenStringContainZero {
    //given
    NSString *stringForValidate = @"x*(x+4) - x*6 + 0";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

- (void)testItNotValidWhenStringContainNotAcceptedCharacters {
    //given
    NSString *stringForValidate = @"x*(x+4) - [x*6]";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

- (void)testItNotValidWhenStringContainNotBalancedParenthesis {
    //given
    NSString *stringForValidate = @"x*(x+4) - (x*6)))";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

- (void)testItNotValidWhenStringContainNotBalancedOpenParenthesis {
    //given
    NSString *stringForValidate = @"x*((((x+4) - (x*6)";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

- (void)testItNotValidWhenXNearNotAcceptedSymbols {
    //given
    NSString *stringForValidate = @"xx";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

- (void)testItNotValidWhenOpenParenthesisNearNotAcceptedSymbols {
    //given
    NSString *stringForValidate = @"x*(*10)";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

- (void)testItNotValidWhenCloseParenthesisNearNotAcceptedSymbols {
    //given
    NSString *stringForValidate = @"x*(*10)25";
    
    //when
    BOOL result = [self.rule validate:stringForValidate];
    
    //then
    XCTAssertFalse(result);
}

@end
