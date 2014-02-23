//
//  ReceiptDataSource.m
//  Budgie
//
//  Created by Stoica Alexandru on 2/23/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "ReceiptDataSource.h"
#import "AFNetworking.h"
#import "Receipt.h"

static NSString const *RailsBaseUrl = @"https://pingle.fwd.wf/" ;
ReceiptDataSource * _receiptDataSource ;

@interface ReceiptDataSource()

@property (strong, nonatomic) AFHTTPRequestOperationManager * manager ;

@end

@implementation ReceiptDataSource


+ (ReceiptDataSource *)getInstance {

    if ( ! _receiptDataSource )
    {
        _receiptDataSource = [[ReceiptDataSource alloc] init];
    }

    return _receiptDataSource ;
}

- (AFHTTPRequestOperationManager *) manager {

    if ( ! _manager )
    {
        _manager = [AFHTTPRequestOperationManager manager] ;
    }

    return _manager ;

}

- (void)parseReceiptListWithCompletion:(void (^)(BOOL))completionBlock {

    NSString *url = [NSString stringWithFormat:@"%@/receipts.json", RailsBaseUrl ] ;

    [self.manager GET:url
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {

                  NSArray * array = responseObject;
                  NSMutableArray * receiptsArray = [[NSMutableArray alloc] init];
                  for ( NSDictionary * receiptJSON in array )
                  {
                      Receipt * receipt = [[Receipt alloc] init];
                      receipt.total = [[receiptJSON valueForKey:@"total"] floatValue];
                      receipt.receipt_id = [[receiptJSON valueForKey:@"id"] integerValue];
                      [receiptsArray addObject:receipt];
                  }

                  self.receiptsArray = receiptsArray ;
                  completionBlock(YES);

              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                  NSLog(@"%@" , error ) ;
                  completionBlock(NO);

              }
    ] ;

}

@end
