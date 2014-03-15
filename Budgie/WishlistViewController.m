//
//  WishlistViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "WishlistViewController.h"
#import "WishListDataSource.h"
#import "Item.h"

@interface WishListViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl ;

@end

@implementation WishListViewController

- (void)viewDidAppear:(BOOL)animated {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
    [[WishListDataSource getInstance] parseWishListWithCompletion:^(BOOL b) {
        [self.tableView reloadData];
    }];
    [self.navigationController setToolbarHidden:NO animated:NO];

}

- (void)viewDidLoad {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WishListDataSource getInstance].wishListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"] ;

    Item * currentItem = [[WishListDataSource getInstance].wishListArray objectAtIndex:indexPath.row] ;

    cell.textLabel.text = currentItem.name ;
    cell.detailTextLabel.text = currentItem.category ;

    return cell ;
}


-(void) getWishList {
    [self.refreshControl beginRefreshing];
    [[WishListDataSource getInstance] parseWishListWithCompletion:^(BOOL b) {
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}


-(void) refresh:(UIRefreshControl *)refreshControl {
    [self getWishList] ;
}

@end
