//
//  AxisBase.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "AxisBase.h"

@implementation AxisBase

- (instancetype)initWithColor:(CGColorRef)color {
    self = [super init];
    if (self) {
        _color = color;
        _nameEnable = YES;
    }
    
    return self;
}

- (void)dealloc {
    CGColorRelease(self.color);
}

@end
