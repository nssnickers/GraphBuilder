//
//  Line.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "Line.h"
#import "GMPoint.h"

@interface Line ()

@property (copy, nonatomic, readwrite) NSArray <GMPoint *>*points;

@end

@implementation Line

- (instancetype)initWithPoints:(NSArray <GMPoint *>*)points color:(CGColorRef)color {
    self = [super init];
    if (self) {
        _points = points;
        _color = color;
    }
    
    return self;
}

- (void)dealloc {
    CGColorRelease(self.color);
}

@end
