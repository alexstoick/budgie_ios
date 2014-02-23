//
//  ReceiptItemsDataSource.h
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiptItemsDataSource : NSObject

+(ReceiptItemsDataSource*)getInstance;

@property(strong,nonatomic) NSArray * receiptItems ;
@property(assign, nonatomic) int current_receipt_id ;

-(void)parseReceiptItemListForReceiptWithId: (int) receipt_id
                       WithCompletion:(void (^)(BOOL))completionBlock;

@end
