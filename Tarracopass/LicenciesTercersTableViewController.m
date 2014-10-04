//
//  LicenciesTercersTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 04/10/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "LicenciesTercersTableViewController.h"
#import "LicenciesTercersDetailViewController.h"

@interface LicenciesTercersTableViewController ()

@end

@implementation LicenciesTercersTableViewController

@synthesize llicencies = _llicencies;

-(NSArray *)llicencies
{
    if (!_llicencies) {
        _llicencies = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Llicencies" ofType:@"plist"]];
    }
    return _llicencies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Llicències de tercers";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.llicencies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *item = (NSDictionary *)[self.llicencies objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item objectForKey:@"name"];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showLlicensiaDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LicenciesTercersDetailViewController *destViewController = segue.destinationViewController;
        destViewController.llicenciesName = [_llicencies objectAtIndex:indexPath.row];
    }
}


@end
