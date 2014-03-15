//
//  WishListItemsTableViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "WishListItemsTableViewController.h"
#import "WishListItemsDataSource.h"
#import "Item.h"

@implementation WishListItemsTableViewController

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 NSLog(@"going back to main view") ;
                             }
     ];
    
}

- (void)viewDidAppear:(BOOL)animated {

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self getItems];

}

-(void) getItems {
    [self.refreshControl beginRefreshing];
    [[WishListItemsDataSource getInstace] parseItemsListWithCompletion:^(BOOL b) {
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

-(void) refresh:(UIRefreshControl *)refreshControl {
    [self getItems] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [[WishListItemsDataSource getInstace] addItemWithIndex:indexPath.row
                                  toWishListWithCompletion:^(BOOL b) {
                                      [self dismissViewControllerAnimated:YES
                                                               completion:^{
                                                                   NSLog(@"going back to main view") ;
                                                               }
                                      ];
                                  }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell" ] ;
    Item * currentItem = [[WishListItemsDataSource getInstace].itemsArray objectAtIndex:indexPath.row] ;

    cell.textLabel.text = currentItem.name ;
    cell.detailTextLabel.text = currentItem.category ;

    return cell ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WishListItemsDataSource getInstace].itemsArray count];
}


@end
