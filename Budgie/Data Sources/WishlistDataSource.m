//
//  WishlistDataSource.m
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "WishlistDataSource.h"
#import "AFNetworking.h"
#import "Item.h"

static NSString const *RailsBaseUrl = @"http://localhost:3000" ;
WishlistDataSource * _wishlistDataSource ;

@interface WishlistDataSource()

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager ;

@end

@implementation WishlistDataSource

+ (WishlistDataSource *) getInstance {

    if ( ! _wishlistDataSource )
    {
        _wishlistDataSource = [[WishlistDataSource alloc] init] ;
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


@end
