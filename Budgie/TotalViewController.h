//
//  TotalViewController.h
//  Budgie
//
//  Created by Stoica Alexandru on 2/22/14.
//  Copyright (c) 2014 Stoica Alexandru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalViewController : UIViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray * selectedItems ;
@property (weak, nonatomic) IBOutlet UILabel *totalSelectedLabel;

@end
