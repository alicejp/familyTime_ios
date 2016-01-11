//
//  EventTableViewController.h
//  familyTime_ios
//
//  Created by alice on 2016/1/11.
//  Copyright © 2016年 alice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
@interface EventTableViewController : UITableViewController <EKEventEditViewDelegate> {
    EKEventViewController *detailViewController;
    EKEventStore *eventStore;
    EKCalendar   *defaultCalendar;
    NSMutableArray *eventsList;
}

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar   *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) EKEventViewController *detailViewController;

@end
