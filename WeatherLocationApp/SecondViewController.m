//
//  SecondViewController.m
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableViewContainer;

@end


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTable:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableViewContainer reloadData];
}

- (void) reloadTable: (UIBarButtonItem*) sender {
    [self.tableViewContainer reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[HistoryManager sharedInstance] itemObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InfoTableViewCell* cell = [[InfoTableViewCell alloc] init];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];

    ItemObject* itemObject = [[[HistoryManager sharedInstance] itemObjects] objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ %.f° (%f  %f)", itemObject.city, itemObject.temperature, itemObject.location.coordinate.latitude, itemObject.location.coordinate.longitude];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@", itemObject.date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FirstViewController* newViewController = [FirstViewController StoryboardInstance];
    
    newViewController.itemObj = [[[HistoryManager sharedInstance] itemObjects] objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:newViewController animated:YES];
}


@end
