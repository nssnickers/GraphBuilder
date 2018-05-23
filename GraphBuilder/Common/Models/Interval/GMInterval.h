//
//  GMInterval.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GMInterval : NSObject

@property (assign, nonatomic) CGFloat max;
@property (assign, nonatomic) CGFloat min;

- (instancetype)initWithMin:(CGFloat)min max:(CGFloat)max NS_DESIGNATED_INITIALIZER;

@end

