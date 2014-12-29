//
//  TipViewController.m
//  tipCalculator
//
//  Created by Ke Huang on 12/28/14.
//  Copyright (c) 2014 Ke Huang. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTipAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTipRate;

- (IBAction)onViewTap:(id)sender;
- (IBAction)onTipRateChanged:(id)sender;
- (IBAction)onBillAmountEditing:(id)sender;
- (void)updateAmount;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calulator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onViewTap:(id)sender {
    [self.view endEditing:YES];
    [self updateAmount];
}

- (IBAction)onTipRateChanged:(id)sender {
    [self updateAmount];
}

- (IBAction)onBillAmountEditing:(id)sender {
    [self updateAmount];
}

- (void)updateAmount {
    float billAmount = [self.txtBillAmount.text floatValue];
    
    NSArray *tipRates = @[@(0.1),@(0.15),@(0.2)];
    
    float currentRate = [tipRates[self.segmentTipRate.selectedSegmentIndex] floatValue];
    float tipAmount = billAmount * currentRate;
    float totalAmount = billAmount + tipAmount;
    
    self.labelTipAmount.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.labelTotalAmount.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

@end
