//
//  YDInboxTableViewCell.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const YDInboxTableViewIdentifier = @"YDInboxTableViewIdentifier";
@interface YDInboxTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
