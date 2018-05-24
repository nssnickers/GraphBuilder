//
//  Legend.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class GMInterval;

@interface Legend : NSObject

@property (assign, nonatomic) CGColorRef color;
@property (strong, nonatomic) GMInterval *range;
@property (assign, nonatomic) CGFloat increment;
@property (assign, nonatomic) CGFloat step;

- (instancetype)initWithRange:(GMInterval *)range increment:(CGFloat)increment color:(CGColorRef)color;

@end
