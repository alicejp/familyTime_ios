//
//  MemberListCell.m
//  familyTime_ios
//
//  Created by alice on 2016/1/10.
//  Copyright © 2016年 alice. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithCustomNibAndController:(UITableViewController *)controller tableRow:(NSInteger)row memberID:(NSInteger)ID{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:K_DETAIL_CELL];
    if (self) {
        if (row == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[Name_ARRAY objectAtIndex:ID]]];
            [self addSubview:imageView];
        }else if (row == 1){
            self.textLabel.text = @"Phone number";
        }else if (row == 2){
            self.textLabel.text = @"0000 0000 0000 0000";
        }else if (row == 3){
            self.textLabel.text = @"Age";
        }else if (row == 4){
            self.textLabel.text = [Age_ARRAY objectAtIndex:ID];
        }

    }
    return self;
}

@end
