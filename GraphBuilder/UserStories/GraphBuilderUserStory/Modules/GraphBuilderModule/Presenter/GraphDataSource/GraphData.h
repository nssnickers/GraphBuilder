//
//  GraphData.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphViewDataSource.h"

@interface GraphData : NSObject <GraphViewDataSource>

@property (strong, nonatomic) NSExpression *expression;

@end
