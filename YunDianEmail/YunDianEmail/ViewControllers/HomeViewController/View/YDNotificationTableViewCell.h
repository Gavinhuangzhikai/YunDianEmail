//
//  YDNotificationTableViewCell.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const YDNotificationTableViewIdentifier = @"YDNotificationTableViewIdentifier";
@interface YDNotificationTableViewCell : UITableViewCell

typedef void(^YDNotificationSelectSwitch)(UISwitch* switc);

@property(nonatomic ,strong) UILabel *titleName;

@property(nonatomic ,strong) UISwitch *selectSeitch;

//@property(nonatomic,copy)YDNotificationSelectSwitch 

+ (instancetype)cellWithTableView:(UITableView *)tableView ;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
