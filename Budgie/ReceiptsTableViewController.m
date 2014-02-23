//
//  ReceiptsTableViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 2/23/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "ReceiptsTableViewController.h"
#import "ReceiptDataSource.h"
#import "Receipt.h"
#import "ItemTableViewController.h"
#import "ReceiptItemsDataSource.h"

@implementation ReceiptsTableViewController

- (void)viewDidAppear:(BOOL)animated {
    [self getReceipts];
}

- (void)viewDidLoad {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

-(void) getReceipts {
    [self.refreshControl beginRefreshing];
    [[ReceiptDataSource getInstance] parseReceiptListWithCompletion:^(BOOL b) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getReceipts];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ReceiptDataSource getInstance].receiptsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];

    Receipt * receipt = [[ReceiptDataSource getInstance].receiptsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"#%d - %@" , receipt.receipt_id , receipt.receipt_day] ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f£" , receipt.total ] ;

    return cell ;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    ItemTableViewController * itemTableViewController = [segue destinationViewController] ;

    NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow] ;
    Receipt * selectedReceipt = [[ReceiptDataSource getInstance].receiptsArray objectAtIndex:indexPath.row] ;

    if ( [ReceiptItemsDataSource getInstance].current_receipt_id != selectedReceipt.receipt_id )
    {
        [ReceiptItemsDataSource getInstance].receiptItems = nil ;
    }

    itemTableViewController.receipt = selectedReceipt ;

}

@end
