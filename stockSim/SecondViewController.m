//
//  SecondViewController.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "SecondViewController.h"
#import "portfolio.h"
#import "stocks.h"
#import <math.h>

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize isRunning;
@synthesize timeInterval;
@synthesize timer;
@synthesize timerStarted;
@synthesize tradeThis;
@synthesize gainLoss;
@synthesize principal;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isRunning = FALSE;
    timerStarted = FALSE;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSNumber *num = [NSNumber numberWithDouble:gainLoss];
    _currentGainLoss.text = [num stringValue];
    _principalAmount.text = [principal stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setTradeFrequency:(id)sender
{
    if (timerStarted == TRUE)
    {
        [timer invalidate];
        timerStarted = FALSE;
    }
    
    timeInterval = _tradeFrequencySlider.value;
}

-(void)updatePrice
{
    [tradeThis updateCurrentPrice];
}

-(void)startTimer
{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updatePrice) userInfo:nil repeats:YES];
    timerStarted = TRUE;
}

- (IBAction)startAlgorithm:(id)sender
{
    //Check if ticker symbol is valid
    //Check if principal is valid
    //Check if stop loss percentage set
    //Check if minimum gain percentage set
    
    if ([_tickerSymbol.text compare:@""] == NSOrderedSame)
    {
        return;
    }
    else if ([_tickerSymbol.text compare:@""] == NSOrderedSame)
    {
        return;
    }
    else if ([_tickerSymbol.text compare:@""] == NSOrderedSame)
    {
        return;
    }
    else if ([_tickerSymbol.text compare:@""] == NSOrderedSame)
    {
        return;
    }
    else if ([_tickerSymbol.text compare:@""] == NSOrderedSame)
    {
        return;
    }
    
    _tickerSymbol.userInteractionEnabled = FALSE;
    _principalAmount.userInteractionEnabled = FALSE;
    _currentGainLoss.userInteractionEnabled = FALSE;
    _stopLossPercentage.userInteractionEnabled = FALSE;
    _minimumGainPercentage.userInteractionEnabled = FALSE;
    
    _tradeFrequencySlider.userInteractionEnabled = TRUE;
    isRunning = TRUE;
    
    while (isRunning == TRUE)
    {
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        principal = [f numberFromString:_principalAmount.text];
        NSNumber *stopLoss = [f numberFromString:_stopLossPercentage.text];
        NSNumber *gainSell = [f numberFromString:_minimumGainPercentage.text];
        
        //While you have money
        while ([principal doubleValue] >= 0.0)
        {
            //Find how many shares we can buy
            tradeThis = [[stocks alloc] initWithTicker:_tickerSymbol.text :TRUE :[NSNumber numberWithInt:1]];
            NSNumber *sharesToBuy = [NSNumber numberWithDouble:([principal doubleValue] / [tradeThis.currentPrice doubleValue])];
            //Round down so we cant overspend
            sharesToBuy = [NSNumber numberWithInt:(floor([sharesToBuy doubleValue]))];
            
            //Buy
            [[portfolio currentPortfolio] addStock:_tickerSymbol.text :TRUE :sharesToBuy];
            //Cost to buy
            NSNumber *cost = [NSNumber numberWithDouble:([sharesToBuy doubleValue]*[[tradeThis currentPrice] doubleValue])];
            
            //Update principal
            principal = [NSNumber numberWithDouble:([principal doubleValue] - [cost doubleValue])];
            
            if (timerStarted == FALSE)
            {
                [self startTimer];
            }
            
            double currentPercent = fabs(1.00 - ([[tradeThis currentPrice] doubleValue] / [[tradeThis priceBoughtAt] doubleValue]));
            
            //Sell at gain
            if ( currentPercent > [gainSell doubleValue])
            {
                [[portfolio currentPortfolio] sellStock:_tickerSymbol.text :TRUE :sharesToBuy];
                
                gainLoss += ([sharesToBuy doubleValue]*[[tradeThis currentPrice] doubleValue] - [sharesToBuy doubleValue]*[[tradeThis priceBoughtAt] doubleValue]);
                
                NSNumber *num = [NSNumber numberWithDouble:gainLoss];
                _currentGainLoss.text = [num stringValue];
                
                //Money made
                NSNumber *made = [NSNumber numberWithDouble:([sharesToBuy doubleValue]*[[tradeThis currentPrice] doubleValue])];
                
                //Update principal
                principal = [NSNumber numberWithDouble:([principal doubleValue] + [made doubleValue])];
            }
            else if (currentPercent <= [stopLoss doubleValue] ) // sell at loss
            {
                [[portfolio currentPortfolio] sellStock:_tickerSymbol.text :TRUE :sharesToBuy];
                gainLoss += ([sharesToBuy doubleValue]*[[tradeThis currentPrice] doubleValue] - [sharesToBuy doubleValue]*[[tradeThis priceBoughtAt] doubleValue]);
                
                NSNumber *num = [NSNumber numberWithDouble:gainLoss];
                _currentGainLoss.text = [num stringValue];
                
                //Money lost
                NSNumber *lost = [NSNumber numberWithDouble:([sharesToBuy doubleValue]*[[tradeThis currentPrice] doubleValue])];
                
                //Update principal
                principal = [NSNumber numberWithDouble:([principal doubleValue] - [lost doubleValue])];
            }
        }
    }
}

- (IBAction)stopAlgorithm:(id)sender
{
    _tickerSymbol.userInteractionEnabled = TRUE;
    _principalAmount.userInteractionEnabled = TRUE;
    _stopLossPercentage.userInteractionEnabled = TRUE;
    _minimumGainPercentage.userInteractionEnabled = TRUE;
    
    _tradeFrequencySlider.userInteractionEnabled = FALSE;
    isRunning = FALSE;
}
@end
