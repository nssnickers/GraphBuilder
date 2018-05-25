//
//  GraphViewProtocol.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GraphConfiguratorProtocol, GraphPresenterProtocol, GraphViewDataSource;

@protocol GraphViewProtocol <NSObject>

- (NSString *)obtainFunctionText;
- (void)updateGraphView;
- (void)setGraphViewDataSource:(id<GraphViewDataSource>)dataSource;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
