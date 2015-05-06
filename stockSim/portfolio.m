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
        _stocks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addStock:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares
{
    if (marketOrder == true)
    {
        stocks *temp = [[stocks alloc]initWithTicker:ticker :marketOrder :numShares];
        [_stocks addObject:temp];
    }
}

- (void) sellStock:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares
{
    if (marketOrder == true)
    {
        for (int i; i < [_stocks count]; i++)
        {
            //Find the ticker, not case sensitive
            if ([[[_stocks objectAtIndex:i] tickerSymbol] caseInsensitiveCompare:ticker] == NSOrderedSame)
            {
                //Only sell if we still own it
                if ([[_stocks objectAtIndex:i] stillOwn] == TRUE)
                {
                    [[_stocks objectAtIndex:i] sellStock:ticker :marketOrder :numShares];
                }
            }
        }
    }
}

@end
