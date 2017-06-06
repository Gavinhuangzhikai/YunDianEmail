
//
//  YDHomeEmailTableViewCell.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDHomeEmailTableViewCell.h"

@implementation YDHomeEmailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    YDHomeEmailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDHomeEmailTableViewIdentifier];
    if (!cell) {
        cell = [[YDHomeEmailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDHomeEmailTableViewIdentifier];
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
    [self.contentView addSubview:self.titleImage];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    [self.contentView addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImage.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    [self.contentView addSubview:self.unreadLabel];
    [self.unreadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImage.mas_left).with.offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.titleName.mas_right).with.offset(10);
        make.height.equalTo(@30);
    }];
    
 

}

#pragma mark - Layz init
- (UILabel *)titleName
{
    if (!_titleName) {
        _titleName = [[UILabel alloc] init];
        _titleName.textColor = YDRGB(22, 22, 22);
        _titleName.font = YDFont(15);
    }
    
    return _titleName;
}
- (UIImageView *)titleImage
{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc] init];
        _titleImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _titleImage;
}


- (UILabel *)unreadLabel
{
    if (!_unreadLabel) {
        _unreadLabel = [[UILabel alloc] init];
        _unreadLabel.textColor = YDRGB(233, 233, 233);
        _unreadLabel.font = YDFont(15);
    }
    
    return _unreadLabel;
}



@end
