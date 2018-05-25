//
//  LineRenderer.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GraphComponentsRenderer.h"

@class Line, GraphViewPort;

@interface LineRenderer : NSObject <GraphComponentsRenderer>

- (instancetype)initWithLine:(Line *)line viewPort:(GraphViewPort *)viewPort;

@end
