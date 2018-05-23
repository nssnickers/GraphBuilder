//
//  Graph.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "Graph.h"
#import "GMPoint.h"
#import "GMInterval.h"

@interface Graph ()

@property (strong, nonatomic) NSExpression *function;

@end

@implementation Graph

- (instancetype)initWithFunction:(NSExpression *)function {
    self = [super init];
    if (self) {
        _function = function;
    }
    
    return self;
}

- (NSArray <GMPoint *>*)obtainPointsWithXInterval:(GMInterval *)xInterval xIncrement:(CGFloat)xIncrement {
    if (!self.function) {
        return @[];
    }
    
    NSMutableArray <GMPoint *> *points = [[NSMutableArray alloc] init];
    
    for (CGFloat x = xInterval.min; x <= xInterval.max; x+= xIncrement) {
        CGFloat y = [self obtainYCoordinateByXCoordinate:x];
        
        if (!isnan(y)) {
            [points addObject:[[GMPoint alloc] initWithX:x y:y]];
        }
    }
    
    return [points copy];
}

- (CGFloat)obtainYCoordinateByXCoordinate:(CGFloat)xCoordinate {
    if (!self.function) {
        return NAN;
    }
    
    return (CGFloat)[[self.function expressionValueWithObject:@{@"x":@(xCoordinate)} context:nil] doubleValue];
}

@end
