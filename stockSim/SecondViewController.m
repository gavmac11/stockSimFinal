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
@synthesize tradeThis;
@synthesize gainLoss;
@synthesize principal;
@synthesize canBuy;
@synthesize stopLoss;
@synthesize gainSell;
@synthesize timer;
@synthesize sharesBought;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isRunning = FALSE;
    canBuy = TRUE;
    principal = [[portfolio currentPortfolio] balance];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSNumber *num = [NSNumber numberWithDouble:gainLoss];
    _currentGainLoss.text = [num stringValue];
    _principalAmount.text = [principal stringValue];
    
    if (!isRunning)
    {
        principal = [[portfolio currentPortfolio] balance];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setTradeFrequency:(id)sender
{
    NSNumber *value = [NSNumber numberWithDouble:_tradeFrequencySlider.value];
    
    timeInterval = [value doubleValue];
    
    if (isRunning == TRUE)
    {
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(stepAlgorithm) userInfo:nil repeats:YES];
    }
}

-(void)updatePrice
{
    [tradeThis updateCurrentPrice];
}

- (void)stepAlgorithm
{
    if (isRunning == TRUE)
    {
        //if you have money
        if ([principal doubleValue] >= 0.0 && canBuy == TRUE)
        {
            //Find how many shares we can buy
            NSNumber *sharesToBuy = [NSNumber numberWithDouble:([principal doubleValue] / [tradeThis.currentPrice doubleValue])];
            //Round down so we cant overspend
            sharesToBuy = [NSNumber numberWithInt:(floor([sharesToBuy doubleValue]))];
            
            //Buy if we have enough money to buy a share
            if ([sharesToBuy intValue] > 0)
            {
                [[portfolio currentPortfolio] addStock:_tickerSymbol.text :TRUE :sharesToBuy];
                //Cost spent
                NSNumber *cost = [NSNumber numberWithDouble:([sharesToBuy doubleValue]*[[tradeThis currentPrice] doubleValue])];
                
                //Keep track of the number of shares that we bought
                sharesBought = sharesToBuy;
                
                //Update principal
                principal = [NSNumber numberWithDouble:([principal doubleValue] - [cost doubleValue])];
                _principalAmount.text = [principal stringValue];
                
                //We use this because we dont want to buy again until we sell what we already bought
                canBuy = FALSE;
            }
            
            
            [self updatePrice];
            
            double currentPercent = (1.00 - ([[tradeThis currentPrice] doubleValue] / [[tradeThis priceBoughtAt] doubleValue]));
            
            //Sell at gain
            if ( fabs(currentPercent) > [gainSell doubleValue])
            {
                [[portfolio currentPortfolio] sellStock:_tickerSymbol.text :TRUE :sharesBought];
                
                gainLoss += ([sharesBought doubleValue]*[[tradeThis currentPrice] doubleValue] - [sharesBought doubleValue]*[[tradeThis priceBoughtAt] doubleValue]);
                
                NSNumber *num = [NSNumber numberWithDouble:gainLoss];
                _currentGainLoss.text = [num stringValue];
                
                //Money made
                NSNumber *made = [NSNumber numberWithDouble:([sharesBought doubleValue]*[[tradeThis currentPrice] doubleValue])];
                
                //Update principal
                principal = [NSNumber numberWithDouble:([principal doubleValue] + [made doubleValue])];
                _principalAmount.text = [principal stringValue];
                
                canBuy = TRUE;
            }
            else if (currentPercent >= [stopLoss doubleValue] ) // sell at loss
            {
                [[portfolio currentPortfolio] sellStock:_tickerSymbol.text :TRUE :sharesBought];
                gainLoss += ([sharesBought doubleValue]*[[tradeThis currentPrice] doubleValue] - [sharesBought doubleValue]*[[tradeThis priceBoughtAt] doubleValue]);
                
                NSNumber *num = [NSNumber numberWithDouble:gainLoss];
                _currentGainLoss.text = [num stringValue];
                
                //Money lost
                NSNumber *lost = [NSNumber numberWithDouble:([sharesBought doubleValue]*[[tradeThis currentPrice] doubleValue])];
                
                //Update principal
                principal = [NSNumber numberWithDouble:([principal doubleValue] - [lost doubleValue])];
                _principalAmount.text = [principal stringValue];
                
                canBuy = TRUE;
            }
        }
    }
    else
    {
        [timer invalidate];
        
        //If we haven't sold the stock yet, sell it because we are stopping the algorithm
        if (canBuy == FALSE)
        {
            [[portfolio currentPortfolio] sellStock:_tickerSymbol.text :TRUE :sharesBought];
            
            gainLoss += ([sharesBought doubleValue]*[[tradeThis currentPrice] doubleValue] - [sharesBought doubleValue]*[[tradeThis priceBoughtAt] doubleValue]);
            
            NSNumber *num = [NSNumber numberWithDouble:gainLoss];
            _currentGainLoss.text = [num stringValue];
            
            //Money made
            NSNumber *made = [NSNumber numberWithDouble:([sharesBought doubleValue]*[[tradeThis currentPrice] doubleValue])];
            
            //Update principal
            principal = [NSNumber numberWithDouble:([principal doubleValue] + [made doubleValue])];
            _principalAmount.text = [principal stringValue];
            
            canBuy = TRUE;
        }
    }
}

- (IBAction)startAlgorithm:(id)sender
{
    if (isRunning == TRUE)
    {
        return;
    }
    else
    {
        //Check if ticker symbol is set
        //Check if principal is set
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
        _currentGainLoss.userInteractionEnabled = FALSE;
        _stopLossPercentage.userInteractionEnabled = FALSE;
        _minimumGainPercentage.userInteractionEnabled = FALSE;
        
        isRunning = TRUE;
        tradeThis = [[stocks alloc] initWithTicker:_tickerSymbol.text :TRUE :[NSNumber numberWithInt:1]];
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        principal = [f numberFromString:_principalAmount.text];
        stopLoss = [f numberFromString:_stopLossPercentage.text];
        gainSell = [f numberFromString:_minimumGainPercentage.text];
        
        [self setTradeFrequency:self];
    }
}

- (IBAction)stopAlgorithm:(id)sender
{
    _tickerSymbol.userInteractionEnabled = TRUE;
    _stopLossPercentage.userInteractionEnabled = TRUE;
    _minimumGainPercentage.userInteractionEnabled = TRUE;
    
    isRunning = FALSE;
    
    portfolio *tempP = [portfolio currentPortfolio];
    tempP.balance = principal;
}
@end
