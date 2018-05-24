//
//  YLegendRenderer.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "YLegendRenderer.h"
#import "Legend.h"
#import "GraphViewPort.h"
#import "GMInterval.h"

@interface YLegendRenderer ()

@property (strong, nonatomic) Legend *yLegend;
@property (strong, nonatomic) GraphViewPort *viewPort;

@end


@implementation YLegendRenderer

- (instancetype)initWithYLegend:(Legend *)yLegend viewPort:(GraphViewPort *)viewPort {
    self = [super init];
    
    if (self) {
        _yLegend = yLegend;
        _viewPort = viewPort;
    }
    
    return self;
}

- (void)drawIntoContext:(CGContextRef)drawingContext {
    CGContextScaleCTM(drawingContext, 1, -1);
    
    for (CGFloat yLegend = self.yLegend.range.min; yLegend <= self.yLegend.range.max; yLegend+= self.yLegend.step) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.f],
                                     NSForegroundColorAttributeName:[UIColor colorWithCGColor:self.yLegend.color]
                                     };
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", yLegend] attributes:attributes];
        
        
        CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)text);
        CGRect lineBounds = CTLineGetImageBounds(line, drawingContext);
        
        CGFloat yLegendScale = self.yLegend.step * self.viewPort.scaleY / self.yLegend.increment;
        CGContextSetTextPosition(drawingContext, 0,  -self.viewPort.zeroPoint.y + yLegendScale * yLegend - lineBounds.size.height/2.f);
        CTLineDraw(line, drawingContext);
        
        CFRelease(line);
    }
    
    CGContextScaleCTM(drawingContext, 1, -1);
}

@end
