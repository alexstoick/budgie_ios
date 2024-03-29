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
#import "TotalViewController.h"

@interface ItemTableViewController()

@end

@implementation ItemTableViewController


- (void)viewDidAppear:(BOOL)animated {
    [self getReceiptData];
}

- (void)viewDidLoad {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

-(void) getReceiptData {
    [[ReceiptItemsDataSource getInstance] parseReceiptItemListForReceiptWithId:self.receipt.receipt_id WithCompletion:^(BOOL b) {
        [self.tableView reloadData];
        NSLog(@"table data has loaded %d" , self.receipt.receipt_id);
        [self.refreshControl endRefreshing];
    }] ;
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    NSLog(@"dsa") ;
    [self getReceiptData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];

    Item * currentItem = [[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:indexPath.row] ;

    //NSLog ( @"%@" , [self.selectedRows indexOfObject: currentItem] ) ;

    cell.textLabel.text = currentItem.name ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f" , currentItem.price] ;

//    [cell setAccessoryType:UITableViewCellAccessoryNone ] ;
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"itemListToTotalView"] )
    {
        NSMutableArray * selectedRows = [[NSMutableArray  alloc] init];

        TotalViewController * totalViewController = (TotalViewController *)[segue destinationViewController] ;

        int count = (int)[[ReceiptItemsDataSource getInstance].receiptItems count];

        for ( int i = 0 ; i < count ; ++ i )
        {
            UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] ;
            if ( cell.accessoryType == UITableViewCellAccessoryCheckmark )
            {
                Item * item = [[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:i] ;
                [selectedRows addObject:item];
            }
        }
        self.selectedRows = selectedRows ;
        totalViewController.selectedItems = selectedRows ;
    }

}

@end


