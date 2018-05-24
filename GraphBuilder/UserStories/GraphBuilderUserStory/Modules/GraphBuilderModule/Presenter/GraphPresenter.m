//
//  GraphPresenter.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GraphPresenter.h"
#import "GraphViewProtocol.h"
#import "GraphInteractorProtocol.h"
#import "GraphData.h"


@implementation GraphPresenter

#pragma mark - GraphPresenterProtocol

- (id<GraphPresenterProtocol>)initWithView:(id<GraphViewProtocol>)view {
    self = [super init];
    
    if (self) {
        _view = view;
    }
    
    return self;
}

- (void)configureView {
    [self.view setGraphViewDataSource:self.graphData];
}

- (void)buildButtonClicked {
    NSString *functionText = [self.view obtainFunctionText];
    
    [self.interactor validateFunction:functionText success:^(){
        self.graphData.expression = [NSExpression expressionWithFormat:[functionText lowercaseString]];
        
        [self.view updateGraphView];
    } failure:^(NSString *title, NSString *message) {
        
        [self.view showAlertWithTitle:title message:message];
    }];
}

@end
