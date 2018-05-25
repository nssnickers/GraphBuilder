//
//  GraphInteractor.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GraphInteractor.h"
#import "Validator.h"
#import "FunctionValidationRule.h"

@interface GraphInteractor ()

@property (copy, nonatomic) NSString *functionValidationErrorMessage;

@end

@implementation GraphInteractor

#pragma mark - lazy instantiation

- (NSString *)functionValidationErrorMessage {
    if (!_functionValidationErrorMessage) {
        _functionValidationErrorMessage = @"В поле ввода могут быть введены только положительные числа, круглые скобки, операции '+', '-', '*', символ 'x', символ пробел.";
    }
    
    return _functionValidationErrorMessage;
}

#pragma mark - GraphInteractorProtocol

- (void)validateFunction:(NSString *)function success:(successValidationBlock)success failure:(failureValidationBlock)failure {
    FunctionValidationRule *functionValidationRule = [[FunctionValidationRule alloc] initWithErrorMessage:self.functionValidationErrorMessage];
    Validator *validator = [Validator new];
    
    [validator validateString:function
                     withRule:functionValidationRule
         validationSuccessful:^{
             
             if (success) {
                 success();
             }
         }
            validationFailure:^(NSString *error) {
                
                if (failure) {
                    failure(@"", error);
                }
            }];
}

@end
