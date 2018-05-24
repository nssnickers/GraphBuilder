//
//  GraphPresenter.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphPresenterProtocol.h"

@class GraphData;

@interface GraphPresenter : NSObject <GraphPresenterProtocol>

@property (weak, nonatomic) id<GraphViewProtocol> view;
@property (strong, nonatomic) id<GraphInteractorProtocol> interactor;
@property (strong, nonatomic) GraphData *graphData;

@end
