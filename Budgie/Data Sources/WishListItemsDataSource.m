//
//  WishListItemsDataSource.m
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "WishListItemsDataSource.h"
#import "AFHTTPRequestOperationManager.h"
#import "Item.h"

static NSString const *RailsBaseUrl = @"http://localhost:3000" ;
WishListItemsDataSource * _wishListItemDataSource ;

@interface WishListItemsDataSource()

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager ;

@end

@implementation WishListItemsDataSource

+ (WishListItemsDataSource *)getInstace {
    if ( ! _wishListItemDataSource )
    {
        _wishListItemDataSource = [[WishListItemsDataSource  alloc] init];
    }
    return _wishListItemDataSource ;
}

- (AFHTTPRequestOperationManager *) manager {

    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager] ;
    }

    return _manager ;

}

- (void)parseItemsListWithCompletion:(void (^)(BOOL))completionBlock {

    NSString * url = [NSString stringWithFormat:@"%@/items.json" , RailsBaseUrl ] ;

    [self.manager GET:url parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {

                NSArray * JSONItemsArray = responseObject ;
                NSMutableArray * itemsArray = [[NSMutableArray alloc] init]

                for (NSDictionary * itemDictionary in JSONItemsArray )
                {
                    Item * currentItem = [[Item alloc] init] ;
                    currentItem.name = [itemDictionary valueForKey:@"name"] ;
                    currentItem.category = [itemDictionary valueForKey:@"category"] ;
                    [itemsArray addObject:currentItem];
                }
                self.itemsArray = itemsArray ;
                completionBlock(YES) ;
        }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog ( @"%@" , error ) ;
                completionBlock(NO) ;
        }
    ]  ;

}


@end
