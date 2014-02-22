//
//  TotalViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "TotalViewController.h"
#import "Item.h"
#import "ItemTableViewController.h"

@implementation TotalViewController

- (void)viewDidLoad {
    [self computeTotalForItems];
}

-(void) computeTotalForItems{

    float total = 0 ;
    for ( Item * item in self.selectedItems )
    {
        total += item.price ;
    }

    self.totalSelectedLabel.text = [NSString stringWithFormat:@"%.2f" , total ] ;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    ItemTableViewController * itemTable = viewController ;
    NSLog(@"321") ;
    itemTable.selectedRows = self.selectedItems ;
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

    NSLog(@"dsa") ;

}

@end
