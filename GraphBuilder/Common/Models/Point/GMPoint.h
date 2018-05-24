//
//  GMPoint.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GMPoint : NSObject

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

- (instancetype)initWithCGPoint:(CGPoint)point;
- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y NS_DESIGNATED_INITIALIZER;

- (CGPoint)CGPoint;

@end
