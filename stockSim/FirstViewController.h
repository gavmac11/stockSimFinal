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


@end

