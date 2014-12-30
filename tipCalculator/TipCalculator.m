//
//  TipCalculator.m
//  tipCalculator
//
//  Created by Ke Huang on 12/29/14.
//  Copyright (c) 2014 Ke Huang. All rights reserved.
//

#import "TipCalculator.h"

@interface TipCalculator ()

@end

NSString *const DEFAULT_TIP_PERCENTAGE_KEY = @"key_defaultTipPercentage";
static TipCalculator *_defaultTipCalculator = nil;

@implementation TipCalculator

@synthesize tipPercentage;
@synthesize tipPercentageDescription;
@synthesize defaultTipPercentage;

-(id)init{
    if (self = [super init]){
        // Setup tip percentage options and related description
        // TODO(kehuang): should read from configuration file
        tipPercentage = @[@(0.10), @(0.15), @(0.2)];
        tipPercentageDescription = @[@"10%", @"15%", @"20%"];
        
        // Retrieve default tip percentage from NSUserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        float defaultValue = [defaults floatForKey:DEFAULT_TIP_PERCENTAGE_KEY];
        if (defaultValue <= 0){
            defaultValue = [tipPercentage[0] floatValue];
        }
        defaultTipPercentage = defaultValue;
        
    }
    return self;
}

-(void)updateDefaultTipPercentage:(float)value{
    defaultTipPercentage = value;
    // save to NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:DEFAULT_TIP_PERCENTAGE_KEY];
    [defaults synchronize];
}

-(int)getIndexOfTipPercentage:(float)percentage{
    for (int i=0; i<tipPercentage.count; i++){
        if ([tipPercentage[i] floatValue] == percentage){
            return i;
        }
    }
    return -1;
}

-(int)getIndexOfDefaultTipPercentage{
    return [self getIndexOfTipPercentage:defaultTipPercentage];
}

-(Tip)calculateTip:(float)billAmount withPercentage:(float)percentage forPersons:(int)personCount{
    Tip tip;
    tip.billAmount = billAmount;
    tip.tipAmount = billAmount * percentage;
    tip.totalAmount = billAmount + tip.tipAmount;
    tip.personCount = personCount;
    tip.tipPerPerson = tip.tipAmount / personCount;
    tip.totalPerPerson = tip.totalAmount / personCount;
    return tip;
}

+(id)defaultTipCalculator{
    if (_defaultTipCalculator == nil){
        _defaultTipCalculator = [[TipCalculator alloc] init];
    }
    return _defaultTipCalculator;
}

@end
