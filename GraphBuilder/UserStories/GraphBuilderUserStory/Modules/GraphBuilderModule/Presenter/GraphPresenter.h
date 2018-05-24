//
//  GraphPresenter.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphPresenterProtocol.h"

@interface GraphPresenter : NSObject <GraphPresenterProtocol>

@property (weak, nonatomic) id<GraphViewProtocol> view;
@property (strong, nonatomic) id<GraphInteractorProtocol> interactor;

@end
