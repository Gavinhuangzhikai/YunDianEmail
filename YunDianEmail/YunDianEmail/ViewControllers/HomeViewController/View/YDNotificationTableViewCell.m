//
//  YDNotificationTableViewCell.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDNotificationTableViewCell.h"

@implementation YDNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    YDNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDNotificationTableViewIdentifier];
    if (!cell) {
        cell = [[YDNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDNotificationTableViewIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatInterface];
    }
    return self;
}

- (void)creatInterface
{
    [self.contentView addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [self.contentView addSubview:self.selectSeitch];
    [self.selectSeitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
}

#pragma mark - Layz init
- (UILabel *)titleName
{
    if (!_titleName) {
        _titleName = [[UILabel alloc] init];
        _titleName.textColor = YDRGB(233, 233, 233);
        _titleName.font = YDFont(15);
    }
    
    return _titleName;
}

- (UISwitch *)selectSeitch
{
    if (!_selectSeitch) {
        _selectSeitch = [[UISwitch alloc] init];
        _selectSeitch.backgroundColor = [UIColor whiteColor];
        _selectSeitch.onTintColor = [UIColor blueColor];
        _selectSeitch.tintColor = [UIColor redColor];
        _selectSeitch.thumbTintColor =[UIColor whiteColor];
        [_selectSeitch addTarget:self action:@selector(selectNotification:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _selectSeitch;
    
}

- (void)selectNotification:(UISwitch *)sswitch
{
//    UISwitch * swidtc = sswitch;
    
    
//    YDNotificationSelectSwitch(swidtc);
    
}
@end
