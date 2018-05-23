//
//  UIBezierPath+GMPoints.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "UIBezierPath+GMPoints.h"
#import "GMPoint.h"

@implementation UIBezierPath (GMPoints)

+ (instancetype)bezierPathWithPoints:(NSArray <GMPoint *> *)points {
    NSMutableArray *rhsArray = [[NSMutableArray alloc] init];
    NSMutableArray *a = [[NSMutableArray alloc] init];
    NSMutableArray *b = [[NSMutableArray alloc] init];
    NSMutableArray *c = [[NSMutableArray alloc] init];
    
    //thomas algorithm
    NSInteger pointsCount = points.count - 1;
    NSMutableDictionary *firstContolPoints = [[NSMutableDictionary alloc] init];
    NSMutableArray *secondContolPoints = [[NSMutableArray alloc] init];
    
    if (pointsCount == 1) {
        CGPoint P0 = [points[0] CGPoint];
        CGPoint P3 = [points[1] CGPoint];
        
        CGFloat P1x, P1y, P2x, P2y;
        
        P1x = (2.f*P0.x + P3.x)/3.f;
        P1y = (2.f*P0.y + P3.y)/3.f;
        
        P2x = (2.f*P1x - P0.x);
        P2y = (2.f*P1y - P0.y);
        
        firstContolPoints[@(0)] = [NSValue valueWithCGPoint:CGPointMake(P1x, P1y)];
        [secondContolPoints addObject:[NSValue valueWithCGPoint:CGPointMake(P2x, P2y)]];
    } else {
        for (NSInteger i = 0; i < pointsCount; i++) {
            CGFloat rhsX, rhsY;
            CGPoint P0 = [points[i] CGPoint];
            CGPoint P3 = [points[i+1] CGPoint];
            
            if (i == 0) {
                // 0*P1(-1) + 2*P1(0) + 1*P1(1) = 1*K(0) + 2*K(1)
                [a addObject:@(0.f)];
                [b addObject:@(2.f)];
                [c addObject:@(1.f)];
                
                rhsX = P0.x + 2.f*P3.x;
                rhsY = P0.y + 2.f*P3.y;
            } else if (i == pointsCount - 1) {
                //2*P1(n-2) + 7*P1(n-1) + 0*P1(n) = 8*K(n-1) + 1*K(n)
                [a addObject:@(2.f)];
                [b addObject:@(7.f)];
                [c addObject:@(0.f)];
                
                rhsX = 8.f*P0.x + P3.x;
                rhsY = 8.f*P0.y + P3.y;
            } else {
                //1*P1(i-2) + 4*P1(i) + 1*P1(i+1) = 4*K(i) + 1*K(i+1)
                [a addObject:@(1.f)];
                [b addObject:@(4.f)];
                [c addObject:@(1.f)];
                
                rhsX = 4.f*P0.x + 2.f*P3.x;
                rhsY = 4.f*P0.y + 2.f*P3.y;
            }
            
            [rhsArray addObject:[NSValue valueWithCGPoint:CGPointMake(rhsX, rhsY)]];
        }
        
        //solve thomas algorithm
        for (NSInteger i = 1; i < pointsCount; i++) {
            CGFloat rhsX = [rhsArray[i] CGPointValue].x;
            CGFloat rhsY = [rhsArray[i] CGPointValue].y;
            
            CGFloat prevRhsX = [rhsArray[i-1] CGPointValue].x;
            CGFloat prevRhsY = [rhsArray[i-1] CGPointValue].y;
            
            CGFloat m = [a[i] floatValue] / [b[i-1] floatValue];
            b[i] = @([b[i] floatValue] - m * [c[i-1] floatValue]);
            
            rhsArray[i] = [NSValue valueWithCGPoint:CGPointMake(rhsX - m * prevRhsX, rhsY - m * prevRhsY)];
        }
        
        // first control points
        CGFloat lastFirstControlPointX = [rhsArray[pointsCount - 1] CGPointValue].x / [b[pointsCount - 1] floatValue];
        CGFloat lastFirstControlPointY = [rhsArray[pointsCount - 1] CGPointValue].y / [b[pointsCount - 1] floatValue];
        
        firstContolPoints[@(pointsCount - 1)] = [NSValue valueWithCGPoint:CGPointMake(lastFirstControlPointX, lastFirstControlPointY)];
        
        for (NSInteger i = pointsCount - 2; i >= 0; i--) {
            CGPoint nextControlPoint = [firstContolPoints[@(i+1)] CGPointValue];
            CGFloat controlPointX = ([rhsArray[i] CGPointValue].x - [c[i] floatValue] * nextControlPoint.x) / [b[i] floatValue];
            CGFloat controlPointY = ([rhsArray[i] CGPointValue].y - [c[i] floatValue] * nextControlPoint.y) / [b[i] floatValue];
            
            firstContolPoints[@(i)] = [NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)];
        }
        
        //second control points based on the firsts
        for (NSInteger i = 0; i < pointsCount; i++) {
            if (i == pointsCount - 1) {
                CGPoint P3 = [points[i+1] CGPoint];
                CGPoint P1 = [firstContolPoints[@(i)] CGPointValue];
                
                CGFloat controlPointX = (P3.x + P1.x)/2.f;
                CGFloat controlPointY = (P3.y + P1.y)/2.f;
                [secondContolPoints addObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
            } else {
                CGPoint P3 = [points[i+1] CGPoint];
                CGPoint P1 = [firstContolPoints[@(i+1)] CGPointValue];
                
                CGFloat controlPointX = 2.f*P3.x - P1.x;
                CGFloat controlPointY = 2.f*P3.y - P1.y;
                [secondContolPoints addObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
            }
        }
    }
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (NSInteger i = 0; i < points.count; i++) {
        CGPoint point = [points[i] CGPoint];
        point.x = point.x;
        point.y = point.y;
        
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            CGPoint controlPoint1 = [firstContolPoints[@(i-1)] CGPointValue];
            CGPoint controlPoint2 = [secondContolPoints[i-1] CGPointValue];
            
            [path addCurveToPoint:point controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        }
    }
    
    return path;
}

@end
