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

- (void) addStock:(NSString *)ticker :(BOOL)marketOrder
{
    if (marketOrder == true)
    {
        stocks *temp = [[stocks alloc]initWithTicker:ticker :marketOrder];
        [_stocks addObject:temp];
    }
}

@end
