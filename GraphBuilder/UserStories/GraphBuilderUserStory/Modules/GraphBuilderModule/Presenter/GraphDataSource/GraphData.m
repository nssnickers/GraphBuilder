//
//  GraphData.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GraphData.h"

#import "GMPoint.h"
#import "GMInterval.h"
#import "Graph.h"

@implementation GraphData

- (NSArray <GMPoint *>*)linePoints {
    if (!self.expression) {
        return @[];
    }
    
    Graph *graph = [[Graph alloc] initWithFunction:self.expression];
    
    CGFloat xPointsIncrement = 1.f;
    GMInterval *pointsInterval = [self xInterval];
    pointsInterval.max += xPointsIncrement;
    pointsInterval.min -= xPointsIncrement;
    
    return [graph obtainPointsWithXInterval:[self xInterval] xIncrement:xPointsIncrement];
}

- (GMInterval *)xInterval {
    return [[GMInterval alloc] initWithMin:-10 max:10];
}

- (GMInterval *)yInterval {
    return [[GMInterval alloc] initWithMin:-10 max:10];
}

- (CGFloat)yIncrement {
    return 1.f;
}

- (CGFloat)xIncrement {
    return 1.f;
}

@end
