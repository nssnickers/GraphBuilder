//
//  Graph.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class GMPoint;
@class GMInterval;

@interface Graph : NSObject

- (instancetype)initWithFunction:(NSExpression *)function NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSArray <GMPoint *>*)obtainPointsWithXInterval:(GMInterval *)xInterval xIncrement:(CGFloat)xIncrement;

@end
