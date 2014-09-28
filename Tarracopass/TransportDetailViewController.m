//
//  TransportDetailViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 26/01/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import "TransportDetailViewController.h"
#import "SVProgressHUD.h"

@interface TransportDetailViewController ()

@end

@implementation TransportDetailViewController

@synthesize transportLocation = _transportLocation;
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    webView.delegate = self;
    
    self.title = @"Quan arriba?";
    
    NSDictionary *item = _transportLocation;
    
    NSLog(@"==================================");
    NSLog(@"%@", item);
    NSLog(@"==================================");
    
    float latitude = [[item objectForKey:@"latitude"] doubleValue];
    float longitude = [[item objectForKey:@"longitude"] doubleValue];
  
    NSString *fullAddressURL = [NSString stringWithFormat:@"http://app.quanarriba.cat/api/1/find_nearest_bus.html?latitude=%f&text=&longitude=%f", latitude, longitude];
    
    NSLog(@"%@", fullAddressURL);
    
    NSURL *url = [NSURL URLWithString:fullAddressURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"Carregant..."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [SVProgressHUD dismiss];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
