//
//  GraphViewPort.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class GMInterval;

@interface GraphViewPort : NSObject

@property (assign, nonatomic, readonly) CGRect frame;
@property (assign, nonatomic, readonly) CGPoint zeroPoint;
@property (assign, nonatomic, readonly) CGFloat scaleX;
@property (assign, nonatomic, readonly) CGFloat scaleY;

- (instancetype)initWithFrame:(CGRect)frame zeroPoint:(CGPoint)zeroPoint scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY;

@end
