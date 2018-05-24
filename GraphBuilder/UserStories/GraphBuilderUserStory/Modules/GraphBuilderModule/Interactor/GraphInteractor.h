//
//  GraphInteractor.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphInteractorProtocol.h"

@interface GraphInteractor : NSObject <GraphInteractorProtocol>

@property (weak, nonatomic) id<GraphPresenterProtocol> presenter;

@end
