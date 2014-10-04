//
//  LicenciesTercersDetailViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 04/10/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "LicenciesTercersDetailViewController.h"

@interface LicenciesTercersDetailViewController ()

@end

@implementation LicenciesTercersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *item = _llicenciesName;
    
    self.title = [item objectForKey:@"name"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    _name.text = [item objectForKey:@"name"];
    _name.textColor = [UIColor colorWithRed:0.98 green:0.54 blue:0.47 alpha:1];
    
    _text.text = [item objectForKey:@"text"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
