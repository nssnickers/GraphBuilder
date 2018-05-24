//
//  LineRenderer.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "LineRenderer.h"
#import "GraphViewPort.h"
#import "Line.h"
#import "UIBezierPath+GMPoints.h"

@interface LineRenderer ()

@property (strong, nonatomic) Line *line;
@property (strong, nonatomic) GraphViewPort *viewPort;

@end

@implementation LineRenderer

- (instancetype)initWithLine:(Line *)line viewPort:(GraphViewPort *)viewPort {
    self = [super init];
    if (self) {
        _line = line;
        _viewPort = viewPort;
    }
    
    return self;
}

- (void)drawIntoContext:(CGContextRef)drawingContext {
    CGContextSaveGState(drawingContext);
    
    if (self.line.points.count > 1) {
        CGContextClipToRect(drawingContext, self.viewPort.frame);
        
        if (self.line.color) {
            CGContextSetStrokeColorWithColor(drawingContext, self.line.color);
        }
        UIBezierPath *line = [UIBezierPath bezierPathWithPoints:self.line.points];
        
        CGContextTranslateCTM(drawingContext, self.viewPort.zeroPoint.x, self.viewPort.zeroPoint.y);
        CGContextScaleCTM(drawingContext, self.viewPort.scaleX, -self.viewPort.scaleY);
        CGContextSetLineWidth(drawingContext, 2.f/self.viewPort.scaleX);
        
        CGPathRef path = [line CGPath];
        CGContextAddPath(drawingContext, path);
        CGContextStrokePath(drawingContext);
    }
    
    CGContextRestoreGState(drawingContext);
}

@end
