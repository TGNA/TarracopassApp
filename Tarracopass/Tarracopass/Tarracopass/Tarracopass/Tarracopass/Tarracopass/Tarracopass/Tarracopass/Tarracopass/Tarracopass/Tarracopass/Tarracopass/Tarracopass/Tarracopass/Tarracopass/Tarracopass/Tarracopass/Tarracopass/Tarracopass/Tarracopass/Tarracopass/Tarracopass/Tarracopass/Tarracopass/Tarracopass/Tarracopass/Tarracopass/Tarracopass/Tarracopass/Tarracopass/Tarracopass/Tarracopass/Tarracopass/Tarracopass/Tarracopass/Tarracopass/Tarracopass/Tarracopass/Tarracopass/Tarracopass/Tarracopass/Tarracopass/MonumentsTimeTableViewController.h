//
//  MonumentsTimeTableViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 26/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTCoreTextView;

@interface MonumentsTimeTableViewController : UIViewController

@property (nonatomic, retain) NSDictionary *monumentsTime;

@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) FTCoreTextView *coreTextViewHorari;

@end
