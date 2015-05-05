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

-(id)initWithTicker:(NSString *)ticker :(BOOL)marketOrder
{
    self = [super init];
    
    if (self)
    {
        _ticker = ticker;
        _priceBoughtAt = [[NSString alloc]init];
        _yql = [[YQL alloc] init];
        
        if (marketOrder == true)
        {
            NSString *queryTemp = [NSString stringWithFormat:@"SELECT * FROM yahoo.finance.quote WHERE symbol=\"%@\"", _ticker];
            
            NSDictionary *company= [_yql query:queryTemp];
            
            NSString *temp = [[company valueForKeyPath:@"query.results"] description];
            
            NSArray *tempArray = [temp componentsSeparatedByString:@"\n"];
            
            NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\"\""];
            
            NSString *marketPrice = [[NSString alloc] init];
            
            for (int i = 0; i <= [tempArray count]; i++)
            {
                if ( [[tempArray objectAtIndex:i] rangeOfString:@"LastTradePriceOnly"].location != NSNotFound )
                {
                  /*  NSRange location = [[tempArray objectAtIndex:i] rangeOfCharacterFromSet:characterSet];
                    NSRange locationTwo = [[tempArray objectAtIndex:i] rangeOfCharacterFromSet:characterSet options:0 range:NSMakeRange(location.location + location.length, [[tempArray objectAtIndex:i] length])];
                    
                    NSString *marketPrice = [[tempArray objectAtIndex:i] substringWithRange:NSMakeRange(location.location, locationTwo.location)];
                    **/
                    
                    
                    NSError *error = nil;
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\"])(?:\\\\\\1|.)*?\\1" options:0 error:&error];
                    NSRange range = [regex rangeOfFirstMatchInString:[tempArray objectAtIndex:i] options:0 range:NSMakeRange(0, [[tempArray objectAtIndex:i] length])];
                    marketPrice = [[tempArray objectAtIndex:i] substringWithRange:range];
                    
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

@end
