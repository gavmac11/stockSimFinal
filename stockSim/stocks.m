//
//  stocks.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/16/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "stocks.h"
#import "YQL.h"
#import "portfolio.h"

@implementation stocks
@synthesize tickerSymbol;
@synthesize currentPrice;
@synthesize priceBoughtAt;
@synthesize numberOfShares;
@synthesize numberOfSharesSold;
@synthesize gainLoss;
@synthesize yql;

-(id)initWithTicker:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares
{
    self = [super init];
    
    if (self)
    {
        tickerSymbol = ticker;
        priceBoughtAt = [[NSNumber alloc]init];
        currentPrice = [[NSNumber alloc]init];
        numberOfShares = numShares;
        numberOfSharesSold = [NSNumber numberWithInt:0];
        gainLoss = [NSNumber numberWithFloat:0.0];
        yql = [YQL currentYQL];
        
        
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        
        if (marketOrder == true)
        {
            NSString *queryTemp = [NSString stringWithFormat:@"SELECT * FROM yahoo.finance.quote WHERE symbol=\"%@\"", tickerSymbol];
            
            NSDictionary *company= [yql query:queryTemp];
            
            NSString *temp = [[company valueForKeyPath:@"query.results"] description];
            
            NSArray *tempArray = [temp componentsSeparatedByString:@"\n"];
            
            //NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\"\""];
            
            NSString *marketPrice = [[NSString alloc] init];
            
            for (int i = 0; i < [tempArray count]; i++)
            {
                if ( [[tempArray objectAtIndex:i] rangeOfString:@"LastTradePriceOnly"].location != NSNotFound )
                {
                    /*  NSRange location = [[tempArray objectAtIndex:i] rangeOfCharacterFromSet:characterSet];
                     NSRange locationTwo = [[tempArray objectAtIndex:i] rangeOfCharacterFromSet:characterSet options:0 range:NSMakeRange(location.location + location.length, [[tempArray objectAtIndex:i] length])];
                     
                     NSString *marketPrice = [[tempArray objectAtIndex:i] substringWithRange:NSMakeRange(location.location, locationTwo.location)];
                     **/
                    
                    //Use NSscanner to change from string to integer
                    NSError *error = nil;
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\"])(?:\\\\\\1|.)*?\\1" options:0 error:&error];
                    NSRange range = [regex rangeOfFirstMatchInString:[tempArray objectAtIndex:i] options:0 range:NSMakeRange(0, [[tempArray objectAtIndex:i] length])];
                    marketPrice = [[tempArray objectAtIndex:i] substringWithRange:range];
                    
                    marketPrice = [marketPrice stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    
                    priceBoughtAt = [formatter numberFromString:marketPrice];
                    [self updateCurrentPrice];
                    
                    
                }
                else
                {
                   // NSLog(@"invalid tick");
                }
            }
            
            //_priceBoughtAt =
            
        }
    }
    
    return self;
}

- (void)updateCurrentPrice
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    NSString *queryTemp = [NSString stringWithFormat:@"SELECT * FROM yahoo.finance.quote WHERE symbol=\"%@\"", tickerSymbol];
    
    NSDictionary *company= [yql query:queryTemp];
    
    NSString *temp = [[company valueForKeyPath:@"query.results"] description];
    
    NSArray *tempArray = [temp componentsSeparatedByString:@"\n"];
    
    
    NSString *marketPrice = [[NSString alloc] init];
    
    for (int i = 0; i < [tempArray count]; i++)
    {
        if ( [[tempArray objectAtIndex:i] rangeOfString:@"LastTradePriceOnly"].location != NSNotFound )
        {
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\"])(?:\\\\\\1|.)*?\\1" options:0 error:&error];
            NSRange range = [regex rangeOfFirstMatchInString:[tempArray objectAtIndex:i] options:0 range:NSMakeRange(0, [[tempArray objectAtIndex:i] length])];
            marketPrice = [[tempArray objectAtIndex:i] substringWithRange:range];
            
            marketPrice = [marketPrice stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            currentPrice = [formatter numberFromString:marketPrice];
            break;
        }
    }
}

- (void) sellStock:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares
{
    NSNumber *sharesLeftAfterSale = [NSNumber numberWithInt:([numberOfShares intValue]- [numShares intValue])];
    if ([sharesLeftAfterSale intValue] < 0)
    {
        return;
    }
    else
    {
        [self updateCurrentPrice];
        
        if ([sharesLeftAfterSale intValue] > 0)
        {
            
            numberOfShares = sharesLeftAfterSale;
            
            //difference between bought and sold in price
            NSNumber *temp = [NSNumber numberWithFloat:([priceBoughtAt floatValue] - [currentPrice floatValue])];
            
            //gain/loss temp
            NSNumber *temp2 = [NSNumber numberWithFloat:([temp floatValue] * [numShares floatValue])];
            
            //Update gain/loss on this stock
            gainLoss = [NSNumber numberWithFloat:([temp2 floatValue] + [gainLoss floatValue])];
            
            //update account gain/loss
            portfolio *tempAccount = [portfolio currentPortfolio];
            tempAccount.gainLoss = [NSNumber numberWithDouble:([tempAccount.gainLoss doubleValue] + [gainLoss doubleValue])];
            
            //update account trade count
            tempAccount.tradeCount = [NSNumber numberWithInt:([tempAccount.tradeCount intValue] + 1)];
            
            //selling value
            NSNumber *sellValue = [NSNumber numberWithDouble:([numShares doubleValue] * [currentPrice doubleValue])];
            //Update account balance
            tempAccount.balance = [NSNumber numberWithDouble:([tempAccount.balance doubleValue] + [sellValue doubleValue])];
            
            [tempAccount.stockHistoryList addObject:self];
            
        }
        else if ([sharesLeftAfterSale intValue] == 0)
        {
            
            numberOfShares = sharesLeftAfterSale;
            
            //difference between bought and sold
            NSNumber *temp = [NSNumber numberWithFloat:([priceBoughtAt floatValue] - [currentPrice floatValue])];
            
            //gain/loss temp
            NSNumber *temp2 = [NSNumber numberWithFloat:([temp floatValue] * [numShares floatValue])];
            
            //update gain/loss on this stock
            gainLoss = [NSNumber numberWithFloat:([temp2 floatValue] + [gainLoss floatValue])];
            
            //update account gain/loss
            portfolio *tempAccount = [portfolio currentPortfolio];
            tempAccount.gainLoss = [NSNumber numberWithDouble:([tempAccount.gainLoss doubleValue] + [gainLoss doubleValue])];
            
            //update account trade count
            tempAccount.tradeCount = [NSNumber numberWithInt:([tempAccount.tradeCount intValue] + 1)];
            
            
            
            //selling value
            NSNumber *sellValue = [NSNumber numberWithDouble:([numShares doubleValue] * [currentPrice doubleValue])];
            //Update account balance
            tempAccount.balance = [NSNumber numberWithDouble:([tempAccount.balance doubleValue] + [sellValue doubleValue])];
            
            [tempAccount.stockHistoryList addObject:self];
            [tempAccount.stockList removeObject:self];
        }
    }
}

@end
