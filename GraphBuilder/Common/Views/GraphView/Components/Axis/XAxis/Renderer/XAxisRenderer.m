//
//  XAxisRenderer.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "XAxisRenderer.h"
#import "GraphViewPort.h"
#import "XAxis.h"

@interface XAxisRenderer ()

@property (strong, nonatomic) XAxis *xAxis;
@property (strong, nonatomic) GraphViewPort *viewPort;

@end

@implementation XAxisRenderer

- (instancetype)initWithXAxis:(XAxis *)xAxis viewPort:(GraphViewPort *)viewPort {
    self = [super init];
    
    if (self) {
        _xAxis = xAxis;
        _viewPort = viewPort;
    }
    
    return self;
}

- (void)drawIntoContext:(CGContextRef)drawingContext {
    if (self.viewPort.zeroPoint.y > self.viewPort.frame.size.height + self.viewPort.frame.origin.y
        || self.viewPort.zeroPoint.y < self.viewPort.frame.origin.y) {
        return;
    }
    
    if (self.xAxis.color) {
        CGContextSetStrokeColorWithColor(drawingContext, self.xAxis.color);
    }
    
    
    CGContextBeginPath(drawingContext);
    CGContextMoveToPoint(drawingContext, self.viewPort.frame.origin.x, self.viewPort.zeroPoint.y);
    CGContextAddLineToPoint(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width, self.viewPort.zeroPoint.y);
    CGContextStrokePath(drawingContext);
    
    CGContextBeginPath(drawingContext);
    CGContextMoveToPoint(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width, self.viewPort.zeroPoint.y);
    CGContextAddLineToPoint(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width - self.viewPort.scaleX/4.f,
                            self.viewPort.zeroPoint.y - self.viewPort.scaleY/5.f);
    CGContextStrokePath(drawingContext);
    
    CGContextBeginPath(drawingContext);
    CGContextMoveToPoint(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width, self.viewPort.zeroPoint.y);
    CGContextAddLineToPoint(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width - self.viewPort.scaleX/4.f,
                            self.viewPort.zeroPoint.y + self.viewPort.scaleY/5.f);
    CGContextStrokePath(drawingContext);
    
    if (self.xAxis.isNameEnabled && self.xAxis.name) {
        CGContextScaleCTM(drawingContext, 1, -1);
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.f]};
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:self.xAxis.name attributes:attributes];
        CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
        
        CGContextSetTextPosition(drawingContext, self.viewPort.frame.origin.x + self.viewPort.frame.size.width + self.viewPort.scaleX/3.f, -self.viewPort.zeroPoint.y - self.viewPort.scaleY/2.f);
        CTLineDraw(line, drawingContext);
        
        CFRelease(line);
        CGContextScaleCTM(drawingContext, 1, -1);
    }
}

@end
