//
//  YQL.h
//  stockSim
//
//  Created by Gavin MacKenzie on 4/13/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQL : NSObject

- (NSDictionary *)query:(NSString *)statement;

@end
