//
//  TotalViewController.m
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import "TotalViewController.h"
#import "Item.h"

@implementation TotalViewController

- (void)viewDidLoad {

    [self computeTotalForItems];

}

-(void) computeTotalForItems{

    float total = 0 ;
    for ( Item * item in self.selectedItems )
    {
        total += item.price ;
    }

    self.totalSelectedLabel.text = [NSString stringWithFormat:@"%.2f" , total ] ;
}


@end
