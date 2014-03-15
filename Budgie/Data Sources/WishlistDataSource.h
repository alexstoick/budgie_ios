//
//  WishlistDataSource.h
//  Budgie
//
//  Created by Stoica Alexandru on 3/15/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WishListDataSource : NSObject

@property (strong,nonatomic) NSArray * wishListArray ;

-(void)parseWishListWithCompletion:(void (^)(BOOL))completionBlock;
+(WishListDataSource *) getInstance ;

@end
