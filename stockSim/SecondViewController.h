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

@property (strong, nonatomic) IBOutlet UITextField *tickerSymbol;
@property (strong, nonatomic) IBOutlet UITextField *principalAmount;
@property (strong, nonatomic) IBOutlet UITextField *currentGainLoss;

@property (strong, nonatomic) IBOutlet UITextField *stopLossPercentage;
@property (strong, nonatomic) IBOutlet UITextField *minimumGainPercentage;
@property (strong, nonatomic) IBOutlet UISlider *tradeFrequencySlider;

@property BOOL isRunning;
@property NSTimeInterval timeInterval;
@property stocks *tradeThis;
@property double gainLoss;
@property BOOL canBuy;
@property NSNumber *stopLoss;
@property NSNumber *gainSell;
@property NSTimer *timer;
@property NSNumber *sharesBought;


- (IBAction)setTradeFrequency:(id)sender;
- (IBAction)startAlgorithm:(id)sender;
- (IBAction)stopAlgorithm:(id)sender;
- (void)stepAlgorithm;

- (void)updatePrice;

@end

