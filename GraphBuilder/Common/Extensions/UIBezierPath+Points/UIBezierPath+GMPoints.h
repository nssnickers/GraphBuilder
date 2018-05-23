//
//  UIBezierPath+GMPoints.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GMPoint;

@interface UIBezierPath (GMPoints)

+ (instancetype)bezierPathWithPoints:(NSArray <GMPoint *> *)points;

@end
