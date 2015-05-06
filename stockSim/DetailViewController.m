//
//  DetailViewController.m
//  stockSim
//
//  Created by Gavin MacKenzie on 5/6/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "DetailViewController.h"
#import "portfolio.h"
#import "ThirdViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    _orderComplete.hidden = TRUE;
    _placeOrderButton.hidden = FALSE;
}

- (void)didReceiveMemoryWarning {
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
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    NSNumber *myNumber = [f numberFromString:_orderShares.text];
    
    //If Market buy
    if (_marketLimitSegmented.selectedSegmentIndex == 0)
    {
        //if buying
        if (_buySellSegmented.selectedSegmentIndex == 0)
        {
            [[portfolio currentPortfolio] addStock:_orderTicker.text :true :myNumber];
        }
        else //if selling
        {
            [[portfolio currentPortfolio] sellStock:_orderTicker.text :TRUE :myNumber];
        }
    }
    else //Limit Buy
    {
        
    }
    
    _orderComplete.hidden = FALSE;
    _orderShares.text = @"";
    _orderTicker.text = @"";
    _placeOrderButton.hidden = TRUE;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
