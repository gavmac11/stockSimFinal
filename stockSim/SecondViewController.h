//
//  SecondViewController.h
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "stocks.h"

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tickerSymbol;
@property (weak, nonatomic) IBOutlet UITextField *principalAmount;
@property (weak, nonatomic) IBOutlet UITextField *currentGainLoss;

@property (weak, nonatomic) IBOutlet UITextField *stopLossPercentage;
@property (weak, nonatomic) IBOutlet UITextField *minimumGainPercentage;
@property (weak, nonatomic) IBOutlet UISlider *tradeFrequencySlider;

@property BOOL isRunning;
@property BOOL timerStarted;
@property NSTimeInterval timeInterval;
@property NSTimer *timer;
@property stocks *tradeThis;
@property double gainLoss;
@property NSNumber *principal;


- (IBAction)setTradeFrequency:(id)sender;
- (IBAction)startAlgorithm:(id)sender;
- (IBAction)stopAlgorithm:(id)sender;

-(void)startTimer;
- (void)updatePrice;

@end

