//
//  WishListItemsTableViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "WishListItemsTableViewController.h"

@implementation WishListItemsTableViewController

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 NSLog(@"going back to main view") ;
                             }
     ];
    
}

@end
