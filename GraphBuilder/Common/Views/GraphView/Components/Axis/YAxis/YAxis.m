//
//  YAxis.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "YAxis.h"

@implementation YAxis

- (instancetype)initWithColor:(CGColorRef)color {
    self = [super initWithColor:color];
    if (self) {
        self.name = @"y";
    }
    
    return self;
}

@end
