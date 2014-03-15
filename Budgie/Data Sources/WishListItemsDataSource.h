//
//  WishListItemsDataSource.h
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WishListItemsDataSource : NSObject

+(WishListItemsDataSource *) getInstace ;

@property (strong, nonatomic) NSArray * itemsArray ;

-(void) parseItemsListWithCompletion:(void(^)(BOOL))completionBlock;

-(void) addItemWithIndex:(int)index toWishListWithCompletion:(void(^)(BOOL))completionBlock ;
@end
