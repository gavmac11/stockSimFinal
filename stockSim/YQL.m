//
//  YQL.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/13/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "YQL.h"

#define QUERY_PREFIX @"http://query.yahooapis.com/v1/public/yql?q="
#define QUERY_SUFFIX @"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="

@implementation YQL

+(YQL *) currentYQL
{
    static YQL *currentYQL = nil;
    
    if (!currentYQL)
    {
        currentYQL = [[super allocWithZone:nil] init];
    }
    
    return currentYQL;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [self currentYQL];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        //Set instance files here!
    }
    
    return self;
}

- (NSDictionary *) query: (NSString *)statement
{
    NSString *query = [NSString stringWithFormat:@"%@%@%@", QUERY_PREFIX, [statement stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], QUERY_SUFFIX];
    
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    
    if (error)
    {
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    }
    
    return results;
}

@end
