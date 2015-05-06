//
//  stocks.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/16/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "stocks.h"
#import "YQL.h"

@implementation stocks
@synthesize tickerSymbol;
@synthesize currentPrice;
@synthesize priceBoughtAt;
@synthesize yql;

-(id)initWithTicker:(NSString *)ticker :(BOOL)marketOrder
{
    self = [super init];
    
    if (self)
    {
        tickerSymbol = ticker;
        priceBoughtAt = [[NSNumber alloc]init];
        currentPrice = [[NSNumber alloc]init];
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
                    
                }
                else
                {
                    //
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

@end
