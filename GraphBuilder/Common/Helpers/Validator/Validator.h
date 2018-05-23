//
//  Validator.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ValidationSuccessBlock) (void);
typedef void (^ValidationFailureBlock) (NSString *error);

@protocol ValidationRule;

@interface Validator : NSObject

- (void)validateString:(NSString *)string
              withRule:(id<ValidationRule>)rule
  validationSuccessful:(ValidationSuccessBlock)success
     validationFailure:(ValidationFailureBlock)failure;

@end
