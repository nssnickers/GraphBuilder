//
//  AxisBase.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface AxisBase : NSObject

@property (assign, nonatomic, getter=isNameEnabled) BOOL nameEnable;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) CGColorRef color;

- (instancetype)initWithColor:(CGColorRef)color;

@end
