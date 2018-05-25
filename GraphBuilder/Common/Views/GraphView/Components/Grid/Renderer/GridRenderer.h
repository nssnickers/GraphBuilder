//
//  GridRenderer.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GraphComponentsRenderer.h"

@class Grid, GraphViewPort;

@interface GridRenderer : NSObject <GraphComponentsRenderer>

- (instancetype)initWithGrid:(Grid *)grid viewPort:(GraphViewPort *)viewPort;

@end
