//
//  Item.h
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong, nonatomic) NSNumber * itemID ;
@property (strong, nonatomic) NSString * name ;
@property (assign, nonatomic) float price ;
@property (strong, nonatomic) NSString * category ;

@end
