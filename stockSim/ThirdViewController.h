//
//  ThirdViewController.h
//  stockSim
//
//  Created by Gavin MacKenzie on 4/1/15.
//  Copyright (c) 2015 Gavin MacKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "portfolio.h"
#import "TabBarViewController.h"

@interface ThirdViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *currentBalance;
@property (weak, nonatomic) IBOutlet UITextField *currentGainLoss;
@property (weak, nonatomic) IBOutlet UITextField *tradeCount;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@property (strong) portfolio *list;


- (IBAction)reset:(id)sender;

@end
