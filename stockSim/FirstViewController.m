//
//  FirstViewController.m
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _currentPositions = [[portfolio alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)marketOrLimitOrder:(id)sender
{
    if ([_marketLimitSegmented selectedSegmentIndex] == 1)
    {
        [_limitPrice setEnabled:true];
        [_limitPrice setHidden:FALSE];
    }
    else
    {
        [_limitPrice setEnabled:FALSE];
        [_limitPrice setHidden:true];
    }
}

- (IBAction)placeOrder:(id)sender
{
    if (_marketLimitSegmented.selectedSegmentIndex == 0)
    {
        [_currentPositions addStock:_orderTicker.text :true];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //temp
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell; //INITIALIZE
    
    return cell;
}
@end
