//
//  FirstViewController.h
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "portfolio.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *positionsTable;
@property portfolio *currentPositions;


//Detail View IB Connections
@property (weak, nonatomic) IBOutlet UISegmentedControl *buySellSegmented;
@property (strong, nonatomic) IBOutlet UITextField *orderTicker;
@property (weak, nonatomic) IBOutlet UITextField *orderShares;
@property (weak, nonatomic) IBOutlet UISegmentedControl *marketLimitSegmented;
@property (weak, nonatomic) IBOutlet UITextField *limitPrice;


- (IBAction)marketOrLimitOrder:(id)sender;

- (IBAction)placeOrder:(id)sender;

@end

