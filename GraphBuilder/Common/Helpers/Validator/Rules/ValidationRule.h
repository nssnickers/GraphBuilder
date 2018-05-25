//
//  ValidationRule.h
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

@protocol ValidationRule

- (BOOL)validate:(NSString *)string;

- (NSString *)errorMessage;

@end
