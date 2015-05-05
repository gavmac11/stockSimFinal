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

- (id)init
{
    self = [super init];
    
    if (self)
    {
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
