//
//  GraphInteractorProtocol.h
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successValidationBlock)(void);
typedef void (^failureValidationBlock)(NSString *title, NSString *message);

@protocol GraphPresenterProtocol;

@protocol GraphInteractorProtocol <NSObject>

- (id<GraphInteractorProtocol>)initWithPresenter:(id<GraphPresenterProtocol>)presenter;

- (void)validateFunction:(NSString *)function success:(successValidationBlock)success failure:(failureValidationBlock)failure;

@end
