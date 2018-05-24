//
//  TestGraph.m
//  GraphBuilderTests
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Graph.h"
#import "GMPoint.h"
#import "GMInterval.h"

@interface TestGraph : XCTestCase

@end

@implementation TestGraph

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCorrectObtainPointsForFunc {
    //given
    Graph *graph = [[Graph alloc] initWithFunction:[NSExpression expressionWithFormat:[@"x*(x+3)" lowercaseString]]];
    GMInterval *xInterval = [[GMInterval alloc] initWithMin:-5 max:5];
    float increment = 1.f;
    
    //when
    NSArray *points = [graph obtainPointsWithXInterval:xInterval xIncrement:increment];
    
    //then
    NSMutableArray *expectedPoints = [[NSMutableArray alloc] init];
    for (float x = xInterval.min; x <= xInterval.max; x += increment) {
        [expectedPoints addObject:[[GMPoint alloc] initWithX:x y:x*(x+3)]];
    }
    
    XCTAssertTrue([self equalGMPointsArrays:points second:[expectedPoints copy]]);
}

- (void)testThatItReturnEmptyPointsArrayWhenIntervalNAN {
    //given
    Graph *graph = [[Graph alloc] initWithFunction:[NSExpression expressionWithFormat:[@"x*(x+3)" lowercaseString]]];
    GMInterval *xInterval = [[GMInterval alloc] init];
    float increment = 1.f;
    
    //when
    NSArray *points = [graph obtainPointsWithXInterval:xInterval xIncrement:increment];
    
    //then
    XCTAssertEqualObjects(points, @[]);
}

- (void)testThatItReturnEmptyPointsArrayWhenFunctionNil {
    //given
    Graph *graph = [[Graph alloc] initWithFunction:nil];
    GMInterval *xInterval = [[GMInterval alloc] init];
    float increment = 1.f;
    
    //when
    NSArray *points = [graph obtainPointsWithXInterval:xInterval xIncrement:increment];
    
    //then
    XCTAssertEqualObjects(points, @[]);
}

#pragma mark - Helper

- (BOOL)equalGMPointsArrays:(NSArray <GMPoint *>*)first second:(NSArray <GMPoint *>*)second {
    if (first.count != second.count) {
        return false;
    }
    
    for (int i = 0; i < first.count; i++) {
        if (fabs(first[i].x - second[i].x) > 0.01 || fabs(first[i].y - second[i].y) > 0.01) {
            return false;
        }
    }
    
    return true;
}

@end

