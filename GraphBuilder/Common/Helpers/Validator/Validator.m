//
//  Validator.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "Validator.h"
#import "ValidationRule.h"

@implementation Validator

- (void)validateString:(NSString *)string
              withRule:(id<ValidationRule>)rule
  validationSuccessful:(ValidationSuccessBlock)success
     validationFailure:(ValidationFailureBlock)failure {
    if ([rule validate:string]) {
        if (success) {
            success();
        }
    } else {
        if (failure) {
            failure([rule errorMessage]);
        }
    }
}

@end
