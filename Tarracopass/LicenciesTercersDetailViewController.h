//
//  LicenciesTercersDetailViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 04/10/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LicenciesTercersDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *llicenciesName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *text;

@end
