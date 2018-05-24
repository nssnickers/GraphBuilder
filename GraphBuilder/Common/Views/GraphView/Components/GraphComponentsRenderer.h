//
//  GraphComponentsRenderer.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>

@protocol GraphComponentsRenderer

- (void)drawIntoContext:(CGContextRef)drawingContext;

@end
