//
//  FunctionValidationRule.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationRule.h"

@interface FunctionValidationRule : NSObject <ValidationRule>

- (instancetype)initWithErrorMessage:(NSString *)errorMessage;

@end
