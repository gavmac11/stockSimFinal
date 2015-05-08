//
//  ThirdViewController.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "ThirdViewController.h"
#import "TabBarViewController.h"
#import "portfolio.h"
#import "stocks.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //list = [portfolio currentPortfolio];
    
    _currentBalance.text = [[[portfolio currentPortfolio] balance] stringValue];
    _tradeCount.text = [[[portfolio currentPortfolio] tradeCount] stringValue];
    _currentGainLoss.text = [[[portfolio currentPortfolio] gainLoss] stringValue];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    _currentBalance.text = [[[portfolio currentPortfolio] balance] stringValue];
    _tradeCount.text = [[[portfolio currentPortfolio] tradeCount] stringValue];
    _currentGainLoss.text = [[[portfolio currentPortfolio] gainLoss] stringValue];
    
    [_historyTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[portfolio currentPortfolio] stockHistoryList] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *CellIdentifier = @"CellIdentifier2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *tick = (UILabel*)[cell.contentView viewWithTag:1];
    [tick setText:@"Symbol"];
    [tick setFont:[UIFont systemFontOfSize:12]];
    
    UILabel *price = (UILabel*)[cell.contentView viewWithTag:2];
    [price setText:@"# Sold"];
    [price setFont:[UIFont systemFontOfSize:12]];
    
    UILabel *gl = (UILabel*)[cell.contentView viewWithTag:3];
    [gl setText:@"+/-"];
    [gl setFont:[UIFont systemFontOfSize:12]];
    
    return cell;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *list = [[portfolio currentPortfolio] stockHistoryList];
    
    static NSString *CellIdentifier = @"CellIdentifier2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *tick = (UILabel*)[cell.contentView viewWithTag:1];
    [tick setText:[[list objectAtIndex:indexPath.row] tickerSymbol]];
    
    UILabel *price = (UILabel*)[cell.contentView viewWithTag:2];
    [price setText:[[[list objectAtIndex:indexPath.row] numberOfSharesSold] stringValue]];
    
    UILabel *gl = (UILabel*)[cell.contentView viewWithTag:3];
    [gl setText:[[[list objectAtIndex:indexPath.row] gainLoss] stringValue]];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reset:(id)sender
{
    portfolio *tempAccount = [portfolio currentPortfolio];
    
    tempAccount.stockList = [[NSMutableArray alloc] init];
    tempAccount.balance = [NSNumber numberWithDouble:5000.0];
    tempAccount.tradeCount = [NSNumber numberWithInt:0];
    tempAccount.gainLoss = [NSNumber numberWithDouble:0.00];
    
    [self viewWillAppear:nil];
}

- (IBAction)clearHistory:(id)sender
{
    portfolio *tempAccount = [portfolio currentPortfolio];
    tempAccount.stockHistoryList = [[NSMutableArray alloc] init];
    [self viewWillAppear:nil];
}
@end
