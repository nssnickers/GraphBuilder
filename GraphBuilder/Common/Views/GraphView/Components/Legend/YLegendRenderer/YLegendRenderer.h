//
//  YLegendRenderer.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GraphComponentsRenderer.h"

@class Legend, GraphViewPort;

@interface YLegendRenderer : NSObject <GraphComponentsRenderer>

- (instancetype)initWithYLegend:(Legend *)yLegend viewPort:(GraphViewPort *)viewPort;

@end
