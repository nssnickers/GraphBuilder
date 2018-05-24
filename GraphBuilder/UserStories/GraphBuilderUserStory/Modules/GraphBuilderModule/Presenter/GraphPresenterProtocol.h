//
//  GraphPresenterProtocol.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GraphViewProtocol, GraphInteractorProtocol;

@protocol GraphPresenterProtocol <NSObject>

- (id<GraphPresenterProtocol>)initWithView:(id<GraphViewProtocol>)view;

- (void)configureView;
- (void)buildButtonClicked;

@end
