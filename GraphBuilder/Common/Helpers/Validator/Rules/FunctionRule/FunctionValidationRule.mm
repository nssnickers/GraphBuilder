//
//  FunctionValidationRule.m
//  GraphBuilder
//
//  Created by Маргарита on 23.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "FunctionValidationRule.h"

#import <stack>


@interface FunctionValidationRule ()

@property (copy, nonatomic) NSString *errorMessage;
@property (strong, nonatomic) NSRegularExpression *expression;

@end

@implementation FunctionValidationRule

- (instancetype)initWithErrorMessage:(NSString *)errorMessage {
    self = [super init];
    if (self) {
        _errorMessage = errorMessage;
    }
    
    return self;
}

- (NSRegularExpression *)expression {
    if (!_expression) {
        NSString *positiveNumber = @"((?<=\\d)\\d)|[1-9]";
        NSString *openingParenthesis = @"((?<=(\\s|\\-|\\+|\\*|\\())\\((?=(x|\\d|\\()))";
        NSString *closingParenthesis = @"((?<=(x|\\d|\\)))\\)(?=(\\)|\\*|\\-|\\+|\\s)))";
        NSString *operators = @"((?<=(x|\\d|\\(|\\)))(\\-|\\*|\\+)(?=(x|\\d|\\)|\\()))";
        NSString *x = @"((?<=(\\(|\\+|\\*|\\-|\\s))x(?=(\\*|\\-|\\+|\\s|\\))))";
        
        NSString *pattern = [NSString stringWithFormat:@"^(\\s|%@|%@|%@|%@|%@)*$", positiveNumber, openingParenthesis, closingParenthesis, operators, x];
        _expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
    }
    
    return _expression;
}

- (NSString *)errorMessage {
    return _errorMessage;
}

- (BOOL)validate:(NSString *)string {
    NSString *normilizedString = [self normilizeString:string];
    
    return ([self validateSymbols:normilizedString] && [self validateBrackets:normilizedString]);
}

#pragma mark - Private Methods

- (NSString *)normilizeString:(NSString *)string {
    NSString *normalizeString = [[string lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [NSString stringWithFormat:@" %@ ", normalizeString];
}

- (BOOL)validateSymbols:(NSString *)string {
    NSUInteger numberOfMatches = [self.expression numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    return numberOfMatches > 0 ? YES : NO;
}

- (BOOL)validateBrackets:(NSString *)string {
    std::stack<char> brackets;
    
    NSUInteger len = string.length;
    unichar buffer[len + 1];
    [string getCharacters:buffer range:NSMakeRange(0, len)];
    
    for (int i = 0; i < len; i++) {
        if (buffer[i] == '(') {
            brackets.push('(');
        } else if(buffer[i] == ')') {
            if (brackets.empty()) {
                return NO;
            } else {
                brackets.pop();
            }
        }
    }
    
    if (!brackets.empty()) {
        return NO;
    }
    
    return YES;
}

@end

