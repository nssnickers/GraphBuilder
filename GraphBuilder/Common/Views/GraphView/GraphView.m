//
//  GraphView.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "GraphView.h"

#import "GraphView.h"
#import "GraphViewPort.h"
#import "GraphViewDataSource.h"

#import "GMPoint.h"
#import "GMInterval.h"

#import "Grid.h"
#import "GridRenderer.h"

#import "XAxis.h"
#import "XAxisRenderer.h"

#import "YAxis.h"
#import "YAxisRenderer.h"

#import "Legend.h"
#import "XLegendRenderer.h"
#import "YLegendRenderer.h"

#import "Line.h"
#import "LineRenderer.h"

static const CGFloat horizontalLegendOffset = 25.f;
static const CGFloat verticalLegendOffset = 25.f;

static const CGFloat defaultYIncrement = 1.f;
static const CGFloat defaultXIncrement = 1.f;


@interface GraphView ()

@property (strong, nonatomic) GraphViewPort *viewPort;

@property (strong, nonatomic) GMInterval *xRange;
@property (strong, nonatomic) GMInterval *yRange;

@property (assign, nonatomic) CGFloat xIncrement;
@property (assign, nonatomic) CGFloat yIncrement;

@end

@implementation GraphView

- (void)drawRect:(CGRect)rect {
    [self initializeViewPort];
    
    CGContextRef drawingContext = UIGraphicsGetCurrentContext();
    
    //grid
    Grid *grid = [[Grid alloc] initWithXRange:self.xRange yRange:self.yRange xIncrement:self.xIncrement yIncrement:self.yIncrement color:CGColorRetain(self.gridColor.CGColor)];
    GridRenderer *gridRenderer = [[GridRenderer alloc] initWithGrid:grid viewPort:self.viewPort];
    [gridRenderer drawIntoContext:drawingContext];
    
    //axis
    XAxis *xAxis = [[XAxis alloc] initWithColor:CGColorRetain(self.axisColor.CGColor)];
    XAxisRenderer *xAxisRenderer = [[XAxisRenderer alloc] initWithXAxis:xAxis viewPort:self.viewPort];
    [xAxisRenderer drawIntoContext:drawingContext];
    
    YAxis *yAxis = [[YAxis alloc] initWithColor:CGColorRetain(self.axisColor.CGColor)];
    YAxisRenderer *yAxisRenderer = [[YAxisRenderer alloc] initWithYAxis:yAxis viewPort:self.viewPort];
    [yAxisRenderer drawIntoContext:drawingContext];
    
    //legend
    Legend *xLegend = [[Legend alloc] initWithRange:self.xRange increment:self.xIncrement color:CGColorRetain(self.legendColor.CGColor)];
    XLegendRenderer *xLegendRenderer = [[XLegendRenderer alloc] initWithXLegend:xLegend viewPort:self.viewPort];
    [xLegendRenderer drawIntoContext:drawingContext];
    
    Legend *yLegend = [[Legend alloc] initWithRange:self.yRange increment:self.yIncrement color:CGColorRetain(self.legendColor.CGColor)];
    YLegendRenderer *yLegendRenderer = [[YLegendRenderer alloc] initWithYLegend:yLegend viewPort:self.viewPort];
    [yLegendRenderer drawIntoContext:drawingContext];
    
    //line
    if (self.dataSource && [self.dataSource linePoints]) {
        Line *line = [[Line alloc] initWithPoints:[self.dataSource linePoints] color:CGColorRetain(self.lineColor.CGColor)];
        LineRenderer *lineRenderer = [[LineRenderer alloc] initWithLine:line viewPort:self.viewPort];
        [lineRenderer drawIntoContext:drawingContext];
    }
}

#pragma mark - Colors lazy instantiation

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor blueColor];
    }
    
    return _lineColor;
}

- (UIColor *)gridColor {
    if (!_gridColor) {
        _gridColor = [UIColor lightGrayColor];
    }
    
    return _gridColor;
}

- (UIColor *)axisColor {
    if (!_axisColor) {
        _axisColor = [UIColor blackColor];
    }
    
    return _axisColor;
}

- (UIColor *)legendColor {
    if (!_legendColor) {
        _legendColor = [UIColor lightGrayColor];
    }
    
    return _legendColor;
}

- (void)initializeViewPort {
    self.xRange = [self.dataSource xInterval] ? [self.dataSource xInterval] : [[GMInterval alloc] initWithMin:-5.f max:5.f];
    self.yRange = [self.dataSource yInterval] ? [self.dataSource yInterval] : [[GMInterval alloc] initWithMin:-5.f max:5.f];
    self.xIncrement = [self.dataSource xIncrement] ? [self.dataSource xIncrement] : defaultXIncrement;
    self.yIncrement = [self.dataSource yIncrement] ? [self.dataSource yIncrement] : defaultYIncrement;
    
    CGRect graphFrame = [self calculateGraphFrame];
    CGFloat xScale = [self calculateXScaleByGraphFrame:graphFrame];
    CGFloat yScale = [self calculateYScaleByGraphFrame:graphFrame];
    [self adjustIntervalsByFrame:graphFrame xScale:xScale yScale:yScale];
    CGPoint zeroPoint = [self calculateZeroPointByXScale:xScale yScale:yScale];
    
    self.viewPort = [[GraphViewPort alloc] initWithFrame:graphFrame zeroPoint:zeroPoint scaleX:xScale scaleY:yScale];
}

#pragma mark - View Port Calculation Helepers

- (CGRect)calculateGraphFrame {
    CGFloat graphWidth = self.bounds.size.width - horizontalLegendOffset * 2.f;
    CGFloat graphHeight = self.bounds.size.height - verticalLegendOffset * 2.f;
    
    return CGRectMake(horizontalLegendOffset, verticalLegendOffset, graphWidth, graphHeight);
}

- (CGFloat)calculateXScaleByGraphFrame:(CGRect)graphFrame {
    CGFloat deltaX = [self deltaX];
    CGFloat deltaY = [self deltaY];
    
    CGFloat xScale = graphFrame.size.width/deltaX;
    CGFloat yScale = graphFrame.size.height/deltaY;
    
    if (xScale > yScale) {
        xScale = yScale * self.xIncrement / self.yIncrement;
    }
    
    return xScale;
}

- (CGFloat)calculateYScaleByGraphFrame:(CGRect)graphFrame {
    CGFloat deltaX = [self deltaX];
    CGFloat deltaY = [self deltaY];
    
    CGFloat xScale = graphFrame.size.width/deltaX;
    CGFloat yScale = graphFrame.size.height/deltaY;
    
    if (yScale > xScale) {
        yScale = xScale * self.yIncrement / self.xIncrement;
    }
    
    return yScale;
}

- (void)adjustIntervalsByFrame:(CGRect)graphFrame xScale:(CGFloat)xScale yScale:(CGFloat)yScale {
    CGFloat deltaX = [self deltaX];
    CGFloat deltaY = [self deltaY];
    
    NSInteger i = 0;
    while (graphFrame.size.width - xScale * (deltaX + 1.0) >= 0) {
        if (i % 2 == 0) {
            self.xRange.min -= self.xIncrement;
        } else {
            self.xRange.max += self.xIncrement;
        }
        deltaX += 1.0;
        i++;
    }
    
    NSInteger j = 0;
    while (graphFrame.size.height - yScale * (deltaY + 1.0) >= 0) {
        if (i % 2 == 0) {
            self.yRange.min -= self.yIncrement;
        } else {
            self.yRange.max += self.yIncrement;
        }
        deltaY += 1.0;
        j++;
    }
}

- (CGPoint)calculateZeroPointByXScale:(CGFloat)xScale yScale:(CGFloat)yScale {
    CGFloat deltaX = [self deltaX];
    CGFloat deltaY = [self deltaY];
    
    CGFloat x = horizontalLegendOffset + xScale * (deltaX - self.xRange.max);
    CGFloat y = self.bounds.size.height - verticalLegendOffset - yScale * (deltaY - self.yRange.max);
    
    return CGPointMake(x,y);
}

- (CGFloat)deltaX {
    return (self.xRange.max - self.xRange.min)/self.xIncrement;
}

- (CGFloat)deltaY {
    return (self.yRange.max - self.yRange.min)/self.yIncrement;
}

@end
