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
#import "SWTableViewCell.h"
#import "ProgressHUD.h"

@interface WishListViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl ;

@end

@implementation WishListViewController

- (void)viewDidAppear:(BOOL)animated {
    if ( ! self.refreshControl )
    {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:self.refreshControl];
    }
    [self.navigationController setToolbarHidden:NO animated:NO];
    [self getWishList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WishListDataSource getInstance].wishListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ddd"];
    
    if (cell == nil) {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f
                         green:0.231f
                          blue:0.188
                         alpha:1.0f]
                                                    title:@"Delete"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"ddd"
                                  containingTableView:self.tableView // For row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }

    Item * currentItem = [[WishListDataSource getInstance].wishListArray objectAtIndex:indexPath.row] ;

    cell.textLabel.text = currentItem.name ;
    cell.detailTextLabel.text = currentItem.category ;

    return cell ;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {

    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell] ;
    [[WishListDataSource getInstance] removeItemWithIndex:indexPath.row
                               fromWishListWithCompletion:^(BOOL b) {
                                   NSLog(@"deleted stuff") ;
                                   [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                    target:self
                                                                  selector:@selector(hideProgressHUDWithTimer:)
                                                                  userInfo:nil
                                                                   repeats:NO];
                               }
    ];

}

-(void)hideProgressHUDWithTimer:(NSTimer*)timer{
    [ProgressHUD dismiss] ;
    [self.tableView reloadData];
}

-(void) getWishList {
    [self.refreshControl beginRefreshing];
    [[WishListDataSource getInstance] parseWishListWithCompletion:^(BOOL b) {
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}


-(void) refresh:(UIRefreshControl *)refreshControl {
    [self getWishList] ;
}

@end
