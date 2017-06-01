//
//  YDHomeEmailTableViewCell.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const YDHomeEmailTableViewIdentifier = @"YDHomeEmailTableViewIdentifier";

@interface YDHomeEmailTableViewCell : UITableViewCell
@property(nonatomic ,strong) UILabel *titleName;
@property(nonatomic ,strong) UIImageView *titleImage;
@property(nonatomic ,strong) UILabel *unreadLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;



@end
