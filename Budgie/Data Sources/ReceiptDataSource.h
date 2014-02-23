//
//  ReceiptDataSource.h
//  Budgie
//
//  Created by Stoica Alexandru on 2/23/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiptDataSource : NSObject

+(ReceiptDataSource *)getInstance ;

@property (strong,nonatomic) NSArray * receiptsArray ;

-(void)parseReceiptListWithCompletion:(void (^)(BOOL))completionBlock;

@end
