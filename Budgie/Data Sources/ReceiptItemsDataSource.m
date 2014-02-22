//
//  ReceiptItemsDataSource.m
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "ReceiptItemsDataSource.h"
#import "AFNetworking.h"
#import "Item.h"

static NSString const *RailsBaseUrl = @"http://pingle.fwd.wf";
ReceiptItemsDataSource * _receiptItemsDataSource ;

@interface  ReceiptItemsDataSource()

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager ;

@end

@implementation ReceiptItemsDataSource



+ (ReceiptItemsDataSource *)getInstance {

    if ( ! _receiptItemsDataSource )
    {
        _receiptItemsDataSource = [[ReceiptItemsDataSource alloc] init];
    }

    return _receiptItemsDataSource ;
}

- (AFHTTPRequestOperationManager *) manager {

    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager] ;
    }

    return _manager ;
}

- (id)parseReceiptItemListForReceiptWithId:(int)receipt_id WithCompletion:(void (^)(BOOL))completionBlock {

    NSString * url = [NSString stringWithFormat:@"%@/receipts/%d",
                                                RailsBaseUrl , receipt_id ];

    [self.manager GET:url
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {

                  NSDictionary * itemsDictionary = [responseObject valueForKey:@"items"] ;
                  float total = [[responseObject valueForKey:@"total"] floatValue] ;
                  NSMutableArray * itemsArray = [[NSMutableArray alloc] init];

                  for ( NSDictionary * item in itemsDictionary )
                  {
                      Item * currentItem = [[Item alloc] init];
                      currentItem.name = [item valueForKey:@"name"] ;
                      currentItem.price = [[item valueForKey:@"price"] floatValue] ;
                      currentItem.category = [[item valueForKey:@"category"] integerValue];
                      [itemsArray addObject:currentItem];
                  }

                  self.receiptItems = itemsArray ;
                  completionBlock(YES);
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  completionBlock(NO);
              }
    ];


}

@end
