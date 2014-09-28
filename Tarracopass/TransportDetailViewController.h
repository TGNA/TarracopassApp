//
//  TransportDetailViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 26/01/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportDetailViewController : UIViewController<UIWebViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSDictionary *transportLocation;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
