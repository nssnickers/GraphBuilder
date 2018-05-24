//
//  Line.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class GMPoint;

@interface Line : NSObject

@property (assign, nonatomic) CGColorRef color;
@property (copy, nonatomic, readonly) NSArray <GMPoint *>*points;

- (instancetype)initWithPoints:(NSArray <GMPoint *>*)points color:(CGColorRef)color;

@end
