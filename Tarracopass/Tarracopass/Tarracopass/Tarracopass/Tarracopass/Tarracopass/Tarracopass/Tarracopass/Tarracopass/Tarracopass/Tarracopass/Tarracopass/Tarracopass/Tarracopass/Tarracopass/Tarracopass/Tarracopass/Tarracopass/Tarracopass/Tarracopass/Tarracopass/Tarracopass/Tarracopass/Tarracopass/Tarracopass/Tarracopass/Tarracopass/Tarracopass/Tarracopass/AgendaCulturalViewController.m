//
//  AgendaCulturalViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 20/08/13.
//  Copyright (c) 2013 Tarracopass. All rights reserved.
//

#import "AgendaCulturalViewController.h"

@interface AgendaCulturalViewController ()

@end

@implementation AgendaCulturalViewController

@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Agenda Cultural";
    
    webView.delegate = self;
    
    NSString *fullAddressURL = [NSString stringWithFormat:@"http://agenda.tarragona.cat/ca/"];
    
    NSString *encodedString = [fullAddressURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    _endavantButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(endavant)];
    _endavantButton.width = 18.0f;
    
    _enrereButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(enrere)];
    _enrereButton.width = 18.0f;
    
    NSArray *actionButtonItems = @[_endavantButton, _enrereButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    UIImage *iconMenu = [UIImage imageNamed:@"menu"];
    iconMenu = [iconMenu imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *background = iconMenu;
    UIImage *backgroundSelected = iconMenu;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [button setBackgroundImage:background forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundSelected forState:UIControlStateSelected];
    button.frame = CGRectMake(0 ,0, 33, 17);
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
}

-(void)menu{
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(void)enrere
{
    [webView goBack];
}
-(void)endavant
{
    [webView goForward];
}

- (void)webViewDidFinishLoad:(UIWebView *)webview{
    [webView stringByEvaluatingJavaScriptFromString:@"$(document).ready(function () {$(\".share\").hide();});$(document).on('pagechange', function() {$(\".share\").hide();});$(document).ready(function () {$(\".add-to-cal\").hide();});$(document).on('pagechange', function() {$(\".add-to-cal\").hide();});$(document).ready(function () {$(\".logo\").hide();});$(document).on('pagechange', function() {$(\".logo\").hide();});$(document).ready(function () {$(\"#parent-fieldname-eventUrl\").hide();});$(document).on('pagechange', function() {$(\"#parent-fieldname-eventUrl\").hide();});"];
    /*
    [_enrereButton setEnabled:[webView canGoBack]];
    [_endavantButton setEnabled:[webView canGoForward]];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
