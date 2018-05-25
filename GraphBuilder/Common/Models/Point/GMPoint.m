//
//  GMPoint.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GMPoint.h"

@implementation GMPoint

- (instancetype)init {
    return [self initWithX:NAN y:NAN];
}

- (instancetype)initWithCGPoint:(CGPoint)point {
    return [self initWithX:point.x y:point.y];
}

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    
    return self;
}

- (CGPoint)CGPoint {
    return CGPointMake(self.x, self.y);
}

@end
