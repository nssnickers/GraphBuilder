//
//  XLegendRenderer.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "XLegendRenderer.h"
#import "Legend.h"
#import "GraphViewPort.h"
#import "GMInterval.h"

@interface XLegendRenderer ()

@property (strong, nonatomic) Legend *xLegend;
@property (strong, nonatomic) GraphViewPort *viewPort;

@end


@implementation XLegendRenderer

- (instancetype)initWithXLegend:(Legend *)xLegend viewPort:(GraphViewPort *)viewPort {
    self = [super init];
    
    if (self) {
        _xLegend = xLegend;
        _viewPort = viewPort;
    }
    
    return self;
}

- (void)drawIntoContext:(CGContextRef)drawingContext {
    CGContextScaleCTM(drawingContext, 1, -1);
    
    for (CGFloat xLegend = self.xLegend.range.min; xLegend <= self.xLegend.range.max; xLegend+= self.xLegend.step) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.f],
                                     NSForegroundColorAttributeName:[UIColor colorWithCGColor:self.xLegend.color]};
        
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", xLegend] attributes:attributes];
        CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
        CGRect lineBounds = CTLineGetImageBounds(line, drawingContext);
        
        CGFloat xLegendScale = self.xLegend.step * self.viewPort.scaleX / self.xLegend.increment;
        CGContextSetTextPosition(drawingContext, self.viewPort.zeroPoint.x + xLegendScale * xLegend - lineBounds.size.width/2.0,
                                 -(self.viewPort.frame.origin.y + self.viewPort.frame.size.height + 10));
        CTLineDraw(line, drawingContext);
        
        CFRelease(line);
    }
    
    CGContextScaleCTM(drawingContext, 1, -1);
}

@end
