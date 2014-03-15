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
#import "ProgressHUD.h"
#import "WishListViewController.h"

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

    [ProgressHUD show:@"Adding item to wish list ... "] ;

    [[WishListItemsDataSource getInstace] addItemWithIndex:indexPath.row
                                  toWishListWithCompletion:^(BOOL b) {
                                      [ProgressHUD showSuccess:@"Successfully added to wish list!"];
                                      [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                       target:self
                                                                     selector:@selector(hideModalView:)
                                                                     userInfo:nil
                                                                      repeats:NO];
                                  }];

}

-(void) hideModalView:(NSTimer*)timer {

    [ProgressHUD dismiss];
    [self dismissViewControllerAnimated:NO
                             completion:^{
                                 NSLog(@"going back to main view") ;
                             }
    ];

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
