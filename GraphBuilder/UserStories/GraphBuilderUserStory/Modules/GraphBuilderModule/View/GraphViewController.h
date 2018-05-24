//
//  GraphViewController.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewProtocol.h"

@class GraphView;

@interface GraphViewController : UIViewController <GraphViewProtocol>

@property (strong, nonatomic) id<GraphConfiguratorProtocol> configurator;
@property (strong, nonatomic) id<GraphPresenterProtocol> presenter;

@end
