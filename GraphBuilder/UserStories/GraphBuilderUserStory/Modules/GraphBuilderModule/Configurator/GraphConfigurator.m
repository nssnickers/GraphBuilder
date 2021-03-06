//
//  GraphConfigurator.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GraphConfigurator.h"
#import "GraphInteractor.h"
#import "GraphPresenter.h"
#import "GraphData.h"
#import "GraphViewController.h"

@implementation GraphConfigurator

- (void)configureView:(GraphViewController *)view {
    GraphPresenter *presenter = [GraphPresenter new];
    presenter.graphData = [[GraphData alloc] init];
    
    GraphInteractor *interactor = [GraphInteractor new];
    interactor.presenter = presenter;
    
    view.presenter = presenter;
    
    presenter.interactor = interactor;
    presenter.view = view;
}

@end
