//
//  Grid.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "Grid.h"
#import "GMInterval.h"

@implementation Grid

- (instancetype)initWithXRange:(GMInterval *)xRange yRange:(GMInterval *)yRange xIncrement:(CGFloat)xIncrement yIncrement:(CGFloat)yIncrement color:(CGColorRef)color {
    self = [super init];
    if (self) {
        _xRange = xRange;
        _yRange = yRange;
        _xIncrement = xIncrement;
        _yIncrement = yIncrement;
        _color = color;
    }
    
    return self;
}

- (void)dealloc {
    CGColorRelease(self.color);
}

@end
