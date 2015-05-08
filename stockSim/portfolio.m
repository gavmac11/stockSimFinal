//
//  portfolio.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/16/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "portfolio.h"
#import "stocks.h"

@implementation portfolio
@synthesize balance;
@synthesize tradeCount;
@synthesize gainLoss;
@synthesize stockList;
@synthesize stockHistoryList;

+(portfolio *) currentPortfolio
{
    static portfolio *currentPortfolio = nil;
    
    if (!currentPortfolio)
    {
        currentPortfolio = [[super allocWithZone:nil] init];
    }
    
    return currentPortfolio;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [self currentPortfolio];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        //Set instance files here!
        stockList = [[NSMutableArray alloc] init];
        stockHistoryList = [[NSMutableArray alloc] init];
        balance = [NSNumber numberWithDouble:5000.00];
        tradeCount = [NSNumber numberWithInt:0];
        gainLoss = [NSNumber numberWithDouble:0.00];
    }
    
    return self;
}

- (void) addStock:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares
{
    if (marketOrder == true)
    {
        stocks *temp = [[stocks alloc]initWithTicker:ticker :marketOrder :numShares];
        [stockList addObject:temp];
        
        //Update account balance
        balance = [NSNumber numberWithDouble:([balance doubleValue] - ([numShares doubleValue] * [[temp currentPrice] doubleValue]))];
        
        //update account number of trades
        tradeCount = [NSNumber numberWithInt:([tradeCount intValue] + 1)];
    }
}

- (void) sellStock:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares
{
    if (marketOrder == true)
    {
        for (int i = 0; i < [stockList count]; i++)
        {
            //Find the ticker, not case sensitive
            if ([[[stockList objectAtIndex:i] tickerSymbol] caseInsensitiveCompare:ticker] == NSOrderedSame)
            {
                //Only sell if we still own it
                NSNumber *tempNum = [NSNumber numberWithInt:([[[stockList objectAtIndex:i] numberOfShares] intValue] - [numShares intValue])];
                if ([tempNum intValue] >= 0)
                {
                    [[stockList objectAtIndex:i] sellStock:ticker :marketOrder :numShares];
                }
            }
        }
    }
}

@end
