//
//  GraphViewPort.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GraphViewPort.h"
#import "GMInterval.h"

@interface GraphViewPort ()

@property (assign, nonatomic, readwrite) CGRect frame;
@property (assign, nonatomic, readwrite) CGPoint zeroPoint;
@property (assign, nonatomic, readwrite) CGFloat scaleX;
@property (assign, nonatomic, readwrite) CGFloat scaleY;

@end

@implementation GraphViewPort

- (instancetype)initWithFrame:(CGRect)frame zeroPoint:(CGPoint)zeroPoint scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    self = [super init];
    if (self) {
        _frame = frame;
        _zeroPoint = zeroPoint;
        _scaleX = scaleX;
        _scaleY = scaleY;
    }
    
    return self;
}

@end
