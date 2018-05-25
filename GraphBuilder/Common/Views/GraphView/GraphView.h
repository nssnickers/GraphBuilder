//
//  GraphView.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GMInterval, GMPoint;
@protocol GraphViewDataSource;

@interface GraphView : UIView

@property (weak, nonatomic) id<GraphViewDataSource> dataSource;

@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) UIColor *axisColor;
@property (strong, nonatomic) UIColor *gridColor;
@property (strong, nonatomic) UIColor *legendColor;

@end
