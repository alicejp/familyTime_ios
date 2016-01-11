//
//  EventTableViewController.m
//  familyTime_ios
//
//  Created by alice on 2016/1/11.
//  Copyright © 2016年 alice. All rights reserved.
//

#import "EventTableViewController.h"

@implementation EventTableViewController
@synthesize eventsList, eventStore, defaultCalendar, detailViewController;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Event List";
    self.eventStore = [[EKEventStore alloc] init];
    self.eventsList = [[NSMutableArray alloc] init];
    self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
    
    self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                              target:self
                                              action:@selector(Add:)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark -
#pragma mark Table view data source
- (NSArray *)fetchEvents {
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:604800];
    NSArray *calendarArray = [NSArray arrayWithObject:defaultCalendar];
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:calendarArray];
    NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
    return events;
}
#pragma Button event

- (void)Add:(id)sender{
    
        // Iterate over all sources in the event store and look for the local source
}
@end



