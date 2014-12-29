//
//  TipViewController.m
//  tipCalculator
//
//  Created by Ke Huang on 12/28/14.
//  Copyright (c) 2014 Ke Huang. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTipAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTipRate;

- (void)updateAmount;

- (IBAction)onViewTap:(id)sender;
- (IBAction)onTipRateChanged:(id)sender;
- (IBAction)onBillAmountEditing:(id)sender;
- (void)onSettingButtonClicked;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onSettingButtonClicked)];
    [self updateAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)onSettingButtonClicked {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
