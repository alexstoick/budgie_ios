//
//  WishlistDataSource.m
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "WishListDataSource.h"
#import "AFNetworking.h"
#import "Item.h"
#import "ProgressHUD.h"

static NSString const *RailsBaseUrl = @"http://localhost:3000" ;
WishListDataSource * _wishlistDataSource ;

@interface WishListDataSource()

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager ;

@end

@implementation WishListDataSource

+ (WishListDataSource *) getInstance {

    if ( ! _wishlistDataSource )
    {
        _wishlistDataSource = [[WishListDataSource alloc] init] ;
    }

    return _wishlistDataSource ;

}

- ( AFHTTPRequestOperationManager *) manager {
    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager] ;
    }

    return _manager ;
}

- (void)parseWishListWithCompletion:(void (^)(BOOL))completionBlock {

    NSString * url = [NSString stringWithFormat:@"%@/users/1/wishlist.json" , RailsBaseUrl ] ;

    [self.manager GET:url
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {

                NSArray * wishListArray =  [responseObject valueForKey:@"wished_items"] ;
                NSMutableArray * itemsArray = [[NSMutableArray alloc] init];

                for ( NSDictionary * itemDictionary in wishListArray )
                {
                    Item * currentItem = [[Item alloc] init];
                    currentItem.itemID = [itemDictionary valueForKey:@"id"] ;
                    currentItem.name = [itemDictionary valueForKey:@"name"] ;
                    currentItem.category = [itemDictionary valueForKey:@"category"] ;
                    [itemsArray addObject:currentItem];
                }

                self.wishListArray = itemsArray ;
                completionBlock(YES) ;
    }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog( @"%@" , error ) ;
              completionBlock(NO);
    }] ;


}


- (void)removeItemWithIndex:(long)index fromWishListWithCompletion:(void (^)(BOOL))completionBlock {

    NSString * url = [NSString stringWithFormat:@"%@/users/1/removeWish" , RailsBaseUrl ];

    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];

    Item * item = [self.wishListArray objectAtIndex:index] ;

    NSMutableArray * itemsArray = [NSMutableArray arrayWithArray:self.wishListArray] ;
    [itemsArray removeObjectAtIndex:index] ;
    self.wishListArray = itemsArray ;

    [params setObject:item.itemID forKey:@"item_id"];

    [ProgressHUD show:@"Deleting from wish list ... "];

    [self.manager DELETE:url
              parameters:params
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     [ProgressHUD showSuccess:@"Successfully deleted from wish list!"];
                     completionBlock(YES) ;

        }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     completionBlock(NO) ;
        }
    ] ;



}


@end
