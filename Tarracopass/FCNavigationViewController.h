//
//  FCNavigationViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 20/12/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCVerticalMenu.h"


@interface FCNavigationViewController : UINavigationController <FCVerticalMenuDelegate>

@property (strong, readonly, nonatomic) FCVerticalMenu *verticalMenu;

-(IBAction)openVerticalMenu:(id)sender;

@end
