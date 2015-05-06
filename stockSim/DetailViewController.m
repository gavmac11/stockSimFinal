//
//  DetailViewController.m
//  stockSim
//
//  Created by Gavin MacKenzie on 5/6/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import "DetailViewController.h"
#import "portfolio.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    //If buy
    if (_marketLimitSegmented.selectedSegmentIndex == 0)
    {
        [[portfolio currentPortfolio] addStock:_orderTicker.text :true];
    }
    else
    {
        
    }
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
