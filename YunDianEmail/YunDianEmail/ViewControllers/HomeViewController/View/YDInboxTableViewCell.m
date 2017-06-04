//
//  YDInboxTableViewCell.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDInboxTableViewCell.h"
@interface YDInboxTableViewCell()

@property (nonatomic,strong) UILabel *senderLabel;

@property (nonatomic,strong) UILabel *themeLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIImageView *annexImage;

@end
@implementation YDInboxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    YDInboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDInboxTableViewIdentifier];
    if (!cell) {
        cell = [[YDInboxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDInboxTableViewIdentifier];
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
    [self.contentView addSubview:self.senderLabel];
    [self.senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-10);
        make.height.equalTo(@30);
    }];
    

    [self.contentView addSubview:self.themeLabel];
    [self.themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.top.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@30);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    
    [self.contentView addSubview:self.annexImage];
    [self.annexImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.senderLabel.mas_right).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
}

#pragma mark - Layz init
- (UILabel *)senderLabel
{
    if (!_senderLabel) {
        _senderLabel = [[UILabel alloc] init];
        _senderLabel.textColor = YDRGB(233, 233, 233);
        _senderLabel.font = YDFont(15);
    }
    
    return _senderLabel;
}
- (UIImageView *)annexImage
{
    if (!_annexImage) {
        _annexImage = [[UIImageView alloc] init];
        _annexImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _annexImage;
}


- (UILabel *)themeLabel
{
    if (!_themeLabel) {
        _themeLabel = [[UILabel alloc] init];
        _themeLabel.textColor = YDRGB(233, 233, 233);
        _themeLabel.font = YDFont(15);
    }
    
    return _themeLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = YDRGB(233, 233, 233);
        _timeLabel.font = YDFont(15);
    }
    
    return _timeLabel;
}
@end
