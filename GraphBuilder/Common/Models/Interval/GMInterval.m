//
//  GMInterval.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GMInterval.h"

@implementation GMInterval

- (instancetype)init {
    return [self initWithMin:NAN max:NAN];
}

- (instancetype)initWithMin:(CGFloat)min max:(CGFloat)max {
    self = [super init];
    if (self) {
        _min = min < max ? min : max;
        _max = max > min ? max : min;
    }
    
    return self;
}

@end
