//
//  YAxisRenderer.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "YAxisRenderer.h"
#import "GraphViewPort.h"
#import "YAxis.h"

@interface YAxisRenderer ()

@property (strong, nonatomic) YAxis *yAxis;
@property (strong, nonatomic) GraphViewPort *viewPort;

@end

@implementation YAxisRenderer

- (instancetype)initWithYAxis:(YAxis *)yAxis viewPort:(GraphViewPort *)viewPort {
    self = [super init];
    
    if (self) {
        _yAxis = yAxis;
        _viewPort = viewPort;
    }
    
    return self;
}

- (void)drawIntoContext:(CGContextRef)drawingContext {
    if (self.viewPort.zeroPoint.x > self.viewPort.frame.size.width + self.viewPort.frame.origin.x
        || self.viewPort.zeroPoint.x < self.viewPort.frame.origin.x) {
        return;
    }
    
    if (self.yAxis.color) {
        CGContextSetStrokeColorWithColor(drawingContext, self.yAxis.color);
    }
    
    
    CGContextBeginPath(drawingContext);
    CGContextMoveToPoint(drawingContext, self.viewPort.zeroPoint.x, self.viewPort.frame.origin.y);
    CGContextAddLineToPoint(drawingContext, self.viewPort.zeroPoint.x, self.viewPort.frame.origin.y + self.viewPort.frame.size.height);
    CGContextStrokePath(drawingContext);
    
    CGContextBeginPath(drawingContext);
    CGContextMoveToPoint(drawingContext, self.viewPort.zeroPoint.x, self.viewPort.frame.origin.y);
    CGContextAddLineToPoint(drawingContext, self.viewPort.zeroPoint.x - self.viewPort.scaleX/5.f,
                            self.viewPort.frame.origin.y + self.viewPort.scaleY/4.f);
    CGContextStrokePath(drawingContext);
    
    CGContextBeginPath(drawingContext);
    CGContextMoveToPoint(drawingContext, self.viewPort.zeroPoint.x, self.viewPort.frame.origin.y);
    CGContextAddLineToPoint(drawingContext, self.viewPort.zeroPoint.x + self.viewPort.scaleX/5.f,
                            self.viewPort.frame.origin.y +  self.viewPort.scaleY/4.f);
    CGContextStrokePath(drawingContext);
    
    if (self.yAxis.isNameEnabled && self.yAxis.name) {
        CGContextScaleCTM(drawingContext, 1, -1);
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.f]};
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:self.yAxis.name attributes:attributes];
        CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
        
        CGContextSetTextPosition(drawingContext, self.viewPort.zeroPoint.x + self.viewPort.scaleX/2.f, -(self.viewPort.frame.origin.y + self.viewPort.scaleY/2.f));
        CTLineDraw(line, drawingContext);
        
        CFRelease(line);
        CGContextScaleCTM(drawingContext, 1, -1);
    }
}

@end
