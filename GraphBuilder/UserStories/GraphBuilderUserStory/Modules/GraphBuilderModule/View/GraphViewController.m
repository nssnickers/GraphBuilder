//
//  GraphViewController.m
//  GraphBuilder
//
//  Created by Маргарита on 24.05.2018.
//  Copyright © 2018 Маргарита. All rights reserved.
//

#import "GraphViewController.h"

#import "GraphConfigurator.h"
#import "GraphPresenterProtocol.h"

#import "GraphView.h"

@interface GraphViewController ()

@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (weak, nonatomic) IBOutlet UITextField *functionText;

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.configurator = [[GraphConfigurator alloc] init];
    [self.configurator configureView:self];
    [self.presenter configureView];
}

#pragma mark - IBAction

- (IBAction)didTapBuildButton:(id)sender {
    [self.presenter buildButtonClicked];
}

#pragma mark - GraphViewProtocol

- (void)updateGraphView {
    [self.graphView setNeedsDisplay];
}

- (NSString *)obtainFunctionText {
    return self.functionText.text;
}

- (void)setGraphViewDataSource:(id<GraphViewDataSource>)dataSource {
    self.graphView.dataSource = dataSource;
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
