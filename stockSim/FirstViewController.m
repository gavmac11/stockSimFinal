//
//  FirstViewController.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "FirstViewController.h"
#import "portfolio.h"
#import "stocks.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _currentPositions = [[portfolio alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSMutableArray *list = [[portfolio currentPortfolio] stockList];
    for (int i = 0; i < [list count]; i++)
    {
        [[[[portfolio currentPortfolio] stockList] objectAtIndex:i] updateCurrentPrice];
    }
    
    
    [_positionsTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    
    for (int i = 0; i < [[[portfolio currentPortfolio] stockList] count]; i++)
    {
        if ([[[[portfolio currentPortfolio] stockList] objectAtIndex:i] stillOwn] == TRUE)
        {
            rowCount++;
        }
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *list = [[portfolio currentPortfolio] stockList];
    for (int i = 0; i < [list count]; i++)
    {
        if ([[list objectAtIndex:i] stillOwn] == FALSE)
        {
            [list removeObjectAtIndex:i];
        }
    }
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *tick = (UILabel*)[cell.contentView viewWithTag:1];
    [tick setText:[[list objectAtIndex:indexPath.row] tickerSymbol]];
    
    UILabel *price = (UILabel*)[cell.contentView viewWithTag:2];
    [price setText:[[[list objectAtIndex:indexPath.row] currentPrice] stringValue]];
    
    UILabel *gl = (UILabel*)[cell.contentView viewWithTag:3];
    [gl setText:[[[list objectAtIndex:indexPath.row] gainLoss] stringValue]];
    
    return cell;
}
@end
