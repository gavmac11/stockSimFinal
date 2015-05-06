//
//  stocks.h
//  stockSim
//
//  Created by Gavin MacKenzie on 4/16/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQL.h"

@interface stocks : NSObject

@property NSString *tickerSymbol;
@property NSNumber *priceBoughtAt;
@property NSNumber *currentPrice;
@property NSNumber *numberOfShares;
@property NSNumber *numberOfSharesSold;
@property NSNumber *gainLoss;
@property BOOL stillOwn;
@property YQL *yql;

- (id)initWithTicker:(NSString*)ticker :(BOOL)marketOrder :(NSNumber*)numShares;
- (void)updateCurrentPrice;

- (void) sellStock:(NSString *)ticker :(BOOL)marketOrder :(NSNumber*)numShares;

@end
