//
//  TimeTableViewController.m
//  familyTime_ios
//
//  Created by alice on 2016/1/10.
//  Copyright © 2016年 alice. All rights reserved.
//

#import "TimeTableViewController.h"
#import "TimeDetailTableViewController.h"
#import "EventTableViewController.h"



@interface TimeTableViewController ()

@end

@implementation TimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                             target:self
                                             action:@selector(Add:)];
    
     self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return Name_ARRAY.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  76;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.alwaysBounceVertical = NO;
    tableView.scrollEnabled = NO;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:K_MEMBER_CELL];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:K_MEMBER_CELL];
    }
    // Configure the cell...
    cell.imageView.image = [UIImage imageNamed:[Name_ARRAY objectAtIndex:indexPath.item]];
    cell.textLabel.text = [Name_ARRAY objectAtIndex:indexPath.item];
    cell.detailTextLabel.text = @"Details about update time";
    cell.detailTextLabel.textColor = TextColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeDetailTableViewController *detailData = [[TimeDetailTableViewController alloc] init];
    detailData.memberID = indexPath.row;
    [self.navigationController pushViewController:detailData animated:YES];
}

- (void)Add:(id)sender{
    EventTableViewController *eventController = [[EventTableViewController alloc]init];
    [self.navigationController pushViewController:eventController animated:YES];
}

@end
