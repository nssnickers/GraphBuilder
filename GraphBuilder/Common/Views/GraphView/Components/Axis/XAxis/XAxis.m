//
//  XAxis.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "XAxis.h"

@implementation XAxis

- (instancetype)initWithColor:(CGColorRef)color {
    self = [super initWithColor:color];
    if (self) {
        self.name = @"x";
    }
    
    return self;
}

@end
