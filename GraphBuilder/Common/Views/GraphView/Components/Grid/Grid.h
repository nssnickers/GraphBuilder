//
//  Grid.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class GMInterval;

@interface Grid : NSObject

@property (assign, nonatomic) CGColorRef color;

@property (assign, nonatomic) CGFloat xIncrement;
@property (assign, nonatomic) CGFloat yIncrement;

@property (strong, nonatomic) GMInterval *xRange;
@property (strong, nonatomic) GMInterval *yRange;

- (instancetype)initWithXRange:(GMInterval *)xRange yRange:(GMInterval *)yRange xIncrement:(CGFloat)xIncrement yIncrement:(CGFloat)yIncrement color:(CGColorRef)color;

@end
