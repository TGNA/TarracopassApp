//
//  AgendaCulturalViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 20/08/13.
//  Copyright (c) 2013 Tarracopass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaCulturalViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@property (nonatomic, retain) UIBarButtonItem *enrereButton;
@property (nonatomic, retain) UIBarButtonItem *endavantButton;

@end
