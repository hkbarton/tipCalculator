//
//  TipViewController.m
//  tipCalculator
//
//  Created by Ke Huang on 12/28/14.
//  Copyright (c) 2014 Ke Huang. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#import "TipCalculator.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtBillAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTipRate;
@property (weak, nonatomic) IBOutlet UILabel *labelBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTipAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelPersonCount;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalPerPerson;
@property (weak, nonatomic) IBOutlet UISlider *sliderPersonCount;

- (void)updateUI;

- (IBAction)onSegmentTipRateValueChanged:(id)sender;
- (IBAction)onBillAmountEditing:(id)sender;
- (IBAction)onSliderPersonCountValueChanged:(id)sender;
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
    TipCalculator *tc = [TipCalculator defaultTipCalculator];
    
    // setup setting button of navigation bar
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(onSettingButtonClicked)];
    // setup segment
    // clear placeholder segments
    [self.segmentTipRate removeAllSegments];
    // init segment with data in TipCalculator
    for (int i=0; i<tc.tipPercentage.count; i++){
        [self.segmentTipRate insertSegmentWithTitle:tc.tipPercentageDescription[i]
                                            atIndex:i
                                           animated:NO];
    }
    // set default selection
    self.segmentTipRate.selectedSegmentIndex = [tc getIndexOfDefaultTipPercentage];
    
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    TipCalculator *tc = [TipCalculator defaultTipCalculator];
    
    // update tip percentage when come back from setting page
    self.segmentTipRate.selectedSegmentIndex = [tc getIndexOfDefaultTipPercentage];
    
    [self updateUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // always focus on txtBillAmount and show keyboard
    [self.txtBillAmount becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSegmentTipRateValueChanged:(id)sender {
    [self updateUI];
}

- (IBAction)onBillAmountEditing:(id)sender {
    [self updateUI];
}

- (IBAction)onSliderPersonCountValueChanged:(id)sender {
    [self updateUI];
}

- (void)onSettingButtonClicked {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)updateUI {
    TipCalculator *tc = [TipCalculator defaultTipCalculator];
    Tip tip = [tc calculateTip:[self.txtBillAmount.text floatValue]
                withPercentage:[tc.tipPercentage[self.segmentTipRate.selectedSegmentIndex] floatValue]
                    forPersons:self.sliderPersonCount.value];
    NSNumberFormatter *currencyFormat = [[NSNumberFormatter alloc] init];
    [currencyFormat setNumberStyle: NSNumberFormatterCurrencyStyle];
    self.labelBillAmount.text = [currencyFormat stringFromNumber: [NSNumber numberWithFloat: tip.billAmount]];
    self.labelTipAmount.text = [currencyFormat stringFromNumber: [NSNumber numberWithFloat: tip.tipAmount]];
    self.labelTotalAmount.text = [currencyFormat stringFromNumber: [NSNumber numberWithFloat: tip.totalAmount]];
    self.labelPersonCount.text = [NSString stringWithFormat: @"%d", tip.personCount];
    self.labelTotalPerPerson.text = [currencyFormat stringFromNumber: [NSNumber numberWithFloat: tip.totalPerPerson]];
}

@end
