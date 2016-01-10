//
//  MemberListCell.h
//  familyTime_ios
//
//  Created by alice on 2016/1/10.
//  Copyright © 2016年 alice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
- (instancetype)initWithCustomNibAndController:(UITableViewController *)controller
                                      tableRow:(NSInteger)row
                                      memberID:(NSInteger)ID;

@end
