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

@property NSString *ticker;
@property NSString *priceBoughtAt;
@property YQL *yql;

- (id)initWithTicker:(NSString*)ticker :(BOOL)marketOrder;

@end
