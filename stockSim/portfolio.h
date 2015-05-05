//
//  portfolio.h
//  stockSim
//
//  Created by Gavin MacKenzie on 4/16/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface portfolio : NSObject

@property (nonatomic, strong) NSMutableArray *stocks;

- (void) addStock:(NSString *)ticker :(BOOL)marketOrder;

@end
