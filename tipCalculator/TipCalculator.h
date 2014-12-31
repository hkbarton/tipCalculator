//
//  TipCalculator.h
//  tipCalculator
//
//  Created by Ke Huang on 12/29/14.
//  Copyright (c) 2014 Ke Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float billAmount;
    float tipAmount;
    float totalAmount;
    int personCount;
    float tipPerPerson;
    float totalPerPerson;
} Tip;

@interface TipCalculator : NSObject

@property (readonly) NSArray* tipPercentage;
@property (readonly) NSArray* tipPercentageDescription;
@property (readonly) float defaultTipPercentage;

-(id)init;

-(void)updateDefaultTipPercentage:(float)value;

-(int)getIndexOfTipPercentage:(float)percentage;
-(int)getIndexOfDefaultTipPercentage;

-(Tip)calculateTip:(float)billAmount withPercentage:(float)percentage forPersons:(int)personCount;

+(id)defaultTipCalculator;

@end
