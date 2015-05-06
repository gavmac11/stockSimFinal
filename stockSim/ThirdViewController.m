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

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize list;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [_tradeHistory count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell; //INITIALIZE
    
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
@end
