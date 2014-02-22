//
//  ItemTableViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "ItemTableViewController.h"
#import "ReceiptItemsDataSource.h"
#import "Item.h"

@implementation ItemTableViewController


- (void)viewDidAppear:(BOOL)animated {

    [[ReceiptItemsDataSource getInstance] parseReceiptItemListForReceiptWithId:(int)@1 WithCompletion:^(BOOL b) {
        [self.tableView reloadData];
        NSLog(@"table data has loaded");
    }] ;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];

    Item * currentItem = [[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:indexPath.row] ;

    cell.textLabel.text = currentItem.name ;

    [cell setAccessoryType:UITableViewCellAccessoryNone ] ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath] ;
    UITableViewCellAccessoryType type = cell.accessoryType ;
    if ( type == UITableViewCellAccessoryCheckmark )
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark ];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ReceiptItemsDataSource getInstance].receiptItems count] ;
}

@end


