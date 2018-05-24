//
//  GraphViewDataSource.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

@class GMPoint, GMInterval;

@protocol GraphViewDataSource

@required
- (NSArray <GMPoint *>*)linePoints;
- (GMInterval *)xInterval;
- (GMInterval *)yInterval;
- (CGFloat)yIncrement;
- (CGFloat)xIncrement;

@end
