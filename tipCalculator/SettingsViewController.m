//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Ke Huang on 12/28/14.
//  Copyright (c) 2014 Ke Huang. All rights reserved.
//

#import "SettingsViewController.h"
#import "TipCalculator.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentDefaultTipPercentage;

- (IBAction)onSegmentDefaultTipPercentageValueChanged:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TipCalculator *tc = [TipCalculator defaultTipCalculator];
    // clear placeholder segment
    [self.segmentDefaultTipPercentage removeAllSegments];
    // init with data in TipCalculator
    for (int i=0; i<tc.tipPercentage.count; i++){
        [self.segmentDefaultTipPercentage insertSegmentWithTitle:tc.tipPercentageDescription[i]
                                                         atIndex:i
                                                        animated:NO];
    }
    // set default selection
    self.segmentDefaultTipPercentage.selectedSegmentIndex = [tc getIndexOfDefaultTipPercentage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSegmentDefaultTipPercentageValueChanged:(id)sender {
    TipCalculator *tc = [TipCalculator defaultTipCalculator];
    [tc updateDefaultTipPercentage:
     [tc.tipPercentage[self.segmentDefaultTipPercentage.selectedSegmentIndex] floatValue]];
}

@end
