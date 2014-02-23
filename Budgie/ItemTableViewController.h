//
//  ItemTableViewController.h
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt.h"

@interface ItemTableViewController : UITableViewController

@property (strong, nonatomic) NSArray * selectedRows ;
@property (strong, nonatomic) Receipt * receipt ;


@end
