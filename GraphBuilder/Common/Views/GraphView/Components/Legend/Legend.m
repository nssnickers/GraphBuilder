//
//  Legend.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "Legend.h"
#import "GMInterval.h"

@implementation Legend

- (instancetype)initWithRange:(GMInterval *)range increment:(CGFloat)increment color:(CGColorRef)color {
    self = [super init];
    if (self) {
        _range = range;
        _increment = increment;
        _step = increment;
        _color = color;
    }
    
    return self;
}

- (void)dealloc {
    CGColorRelease(self.color);
}

@end
