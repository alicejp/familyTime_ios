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
    self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                              target:self
                                              action:@selector(AddEvent:)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self checkEntity];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

#pragma mark -
#pragma mark Table view data source
- (void)checkEntity{
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        // iOS 6 and later
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                [self performCalendarActivity];
            } else {
                //NOT allow your app to access the calendar
            }
        }];
    } else {
        [self performCalendarActivity];
    }
}

-(void)performCalendarActivity{
    self.eventStore = [[EKEventStore alloc] init];
    eventsList = [[NSMutableArray alloc] init];
    self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
    eventsList= [[self fetchEvents] mutableCopy];
}

- (NSArray *)fetchEvents {
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:604800];
    NSArray *calendarArray = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    
    // Create the predicate
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:calendarArray];
    NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
    return events;
}


#pragma Button event

- (void)AddEvent:(id)sender{
    EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
    addController.eventStore = self.eventStore;
    [self presentViewController:addController animated:YES completion:nil];
    addController.editViewDelegate = self;
}

#pragma mark -
#pragma EKEventEditViewDelegate

- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action{
    NSError *anError = nil;
    EKEvent *thisEvent = controller.event;
    NSLog(@"action :%ld",(long)action);
    
    switch (action) {
        case EKEventEditViewActionCanceled:
            break;
            
        case EKEventEditViewActionSaved:
            if (self.defaultCalendar == thisEvent.calendar) {
                [self.eventsList addObject:thisEvent];
            }
            [controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&anError];
            [self.tableView reloadData];
            break;
        
        case EKEventEditViewActionDeleted:
            if (self.defaultCalendar == thisEvent.calendar) {
                [self.eventsList removeObject:thisEvent];
            }
            [controller.eventStore removeEvent:controller.event span:EKSpanThisEvent error:&anError];
            [self.tableView reloadData];
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}


//Set the calendar to the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller{
    EKCalendar *calendarForEdit = self.defaultCalendar;
    return calendarForEdit;
}

#pragma mark -
#pragma Navigation Controller delegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (viewController == self && self.detailViewController.event.title == NULL) {
//        [self.eventsList removeObject:self.detailViewController.event];
//        [self.tableView reloadData];
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return eventsList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  76;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.alwaysBounceVertical = NO;
    tableView.scrollEnabled = NO;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:K_Event_CELL];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:K_MEMBER_CELL];
    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.eventsList objectAtIndex:indexPath.row] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailViewController = [[EKEventViewController alloc] initWithNibName:nil bundle:nil];
    detailViewController.event = [self.eventsList objectAtIndex:indexPath.row];
    detailViewController.allowsEditing = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end



