//
//  GridRenderer.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GridRenderer.h"
#import "Grid.h"
#import "GraphViewPort.h"
#import "GMInterval.h"

@interface GridRenderer ()

@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) GraphViewPort *viewPort;

@end

@implementation GridRenderer

- (instancetype)initWithGrid:(Grid *)grid viewPort:(GraphViewPort *)viewPort {
    self = [super init];
    
    if (self) {
        _grid = grid;
        _viewPort = viewPort;
    }
    
    return self;
}

- (void)drawIntoContext:(CGContextRef)drawingContext {
    if (self.grid.color) {
        CGContextSetStrokeColorWithColor(drawingContext, self.grid.color);
    }
    
    //horizontal
    for (CGFloat y = self.grid.yRange.min; y <= self.grid.yRange.max; y += self.grid.yIncrement) {
        
        CGContextBeginPath(drawingContext);
        CGContextMoveToPoint(drawingContext, self.viewPort.frame.origin.x, self.viewPort.zeroPoint.y - y * self.viewPort.scaleY);
        CGContextAddLineToPoint(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width, self.viewPort.zeroPoint.y - y * self.viewPort.scaleY);
        CGContextStrokePath(drawingContext);
    }
    
    //vertical
    for (CGFloat x = self.grid.xRange.min; x <= self.grid.xRange.max; x += self.grid.xIncrement) {
        
        CGContextBeginPath(drawingContext);
        CGContextMoveToPoint(drawingContext, self.viewPort.zeroPoint.x + x * self.viewPort.scaleX, self.viewPort.frame.origin.y);
        CGContextAddLineToPoint(drawingContext, self.viewPort.zeroPoint.x + x * self.viewPort.scaleX, self.viewPort.frame.origin.y + self.viewPort.frame.size.height);
        CGContextStrokePath(drawingContext);
    }
}

@end
