//
//  DetailViewController.h
//  stockSim
//
//  Created by Gavin MacKenzie on 5/6/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

//Detail View IB Connections
@property (weak, nonatomic) IBOutlet UISegmentedControl *buySellSegmented;
@property (strong, nonatomic) IBOutlet UITextField *orderTicker;
@property (weak, nonatomic) IBOutlet UITextField *orderShares;
@property (weak, nonatomic) IBOutlet UISegmentedControl *marketLimitSegmented;
@property (weak, nonatomic) IBOutlet UITextField *limitPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderComplete;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *limitOrderPriceLabel;


- (IBAction)marketOrLimitOrder:(id)sender;

- (IBAction)placeOrder:(id)sender;

@end
