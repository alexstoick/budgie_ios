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

@property (assign, nonatomic) NSArray * selectedRows ;

@end

@implementation ItemTableViewController


- (void)viewDidAppear:(BOOL)animated {
    [self getReceiptData];
    self.selectedRows = [[NSArray alloc] init];
}



- (void)viewDidLoad {

    self.refreshControl = [[UIRefreshControl alloc] init];

    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];


}

-(void) getReceiptData {
    [[ReceiptItemsDataSource getInstance] parseReceiptItemListForReceiptWithId:(int)@1 WithCompletion:^(BOOL b) {
        [self.tableView reloadData];
        NSLog(@"table data has loaded");
        [self.refreshControl endRefreshing];
    }] ;
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getReceiptData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];

    Item * currentItem = [[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:indexPath.row] ;

    cell.textLabel.text = currentItem.name ;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f" , currentItem.price] ;

    [cell setAccessoryType:UITableViewCellAccessoryNone ] ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath] ;
    UITableViewCellAccessoryType type = cell.accessoryType ;

    if ( type == UITableViewCellAccessoryCheckmark )
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        Item * currentItem =[[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:indexPath.row] ;
        NSLog(@"%@" , currentItem ) ;
        NSMutableArray * newArray = [NSMutableArray arrayWithArray:self.selectedRows] ;
        [newArray removeObject: currentItem ] ;
        self.selectedRows = newArray ;
        //[self.selectedRows removeObject:[[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark ];
        Item * currentItem =[[ReceiptItemsDataSource getInstance].receiptItems objectAtIndex:indexPath.row] ;
        NSLog(@"%@" , currentItem ) ;

        NSMutableArray * newArray = [NSMutableArray arrayWithArray:self.selectedRows] ;
        [newArray addObject: currentItem ] ;
        self.selectedRows = newArray ;

//        [self.selectedRows addObject: currentItem ] ;
//        NSMutableArray * newArray = [NSMutableArray arrayWithArray:self.selectedRows];
//        [newArray addObject:[NSNumber numberWithInteger:indexPath.row]];
//        self.selectedRows = newArray ;
        //NSLog(@"%@" , self.selectedRows ) ;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //sNSLog(@"%@" , self.selectedRows ) ;
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
        TotalViewController * totalViewController = [segue destinationViewController] ;
        totalViewController.selectedItems = self.selectedRows ;
    }

}

@end


