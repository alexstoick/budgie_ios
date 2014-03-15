//
//  WishlistViewController.h
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface WishListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>

-(void) getWishList ;

@end
