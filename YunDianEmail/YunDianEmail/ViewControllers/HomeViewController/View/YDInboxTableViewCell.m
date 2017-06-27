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
@property (nonatomic,strong) UIImageView *isOrRead;
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

    [self.contentView addSubview:self.isOrRead];
    [self.isOrRead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-8);
        make.height.equalTo(@8);
        make.width.equalTo(@8);
    }];
    
    
    
    self.isOrRead.hidden = YES;
    [self.contentView addSubview:self.senderLabel];
    [self.senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-5);
        make.height.equalTo(@15);
    }];
    

    [self.contentView addSubview:self.themeLabel];
    [self.themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.top.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@15);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-5);
        make.height.equalTo(@12);
        make.width.equalTo(@90);
    }];
    
    [self.contentView addSubview:self.annexImage];
    [self.annexImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.senderLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.isOrRead.mas_centerY);
        make.height.equalTo(@12);
        make.width.equalTo(@12);
    }];
    
}

#pragma mark - Layz init
- (UILabel *)senderLabel
{
    if (!_senderLabel) {
        _senderLabel = [[UILabel alloc] init];
        _senderLabel.textColor = YDRGB(0, 0, 87);
        _senderLabel.font = YDFont(12);
    }
    
    return _senderLabel;
}

- (UIImageView *)isOrRead
{
    if (!_isOrRead) {
        _isOrRead = [[UIImageView alloc] init];
//        _isOrRead.frame = CGRectMake(15, self.contentView.width/2 -20, 15, 15);
        _isOrRead.contentMode = UIViewContentModeScaleAspectFit;
        _isOrRead.backgroundColor = YDRGB(0, 112, 204);
        _isOrRead.layer.cornerRadius = 7.5;
        _isOrRead.layer.masksToBounds = YES;
        
    }
    return _isOrRead;
}


- (UIImageView *)annexImage
{
    if (!_annexImage) {
        _annexImage = [[UIImageView alloc] init];
        _annexImage.contentMode = UIViewContentModeScaleAspectFit;
        _annexImage.image =[UIImage imageNamed:@"email_notification_icon"];
        _annexImage.hidden = YES;
    }
    return _annexImage;
}


- (UILabel *)themeLabel
{
    if (!_themeLabel) {
        _themeLabel = [[UILabel alloc] init];
        _themeLabel.textColor = YDRGB(0, 0, 102);
        _themeLabel.font = YDFont(12);
    }
    
    return _themeLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = YDRGB(91, 91, 91);
        _timeLabel.font = YDFont(8);
    }
    
    return _timeLabel;
}

- (void)refreshDataWithCell:(YDInBoxRowsModel *)inboxrows
{
    self.senderLabel.text = inboxrows.tomail;
    self.themeLabel.text = inboxrows.subject;
    self.timeLabel.text  = inboxrows.sentDate;
    
    if ([inboxrows.isNew isEqualToString:@"0"]) {

        self.isOrRead.hidden = NO;
        
        [self.senderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(25);
            make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-5);
            make.height.equalTo(@15);
        }];
        
//        [UIView animateWithDuration:0.1f animations:^{
//            [self.contentView layoutIfNeeded];
//        }];
    }else{
        self.isOrRead.hidden = YES;
        
        [self.senderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(15);
            make.bottom.equalTo(self.contentView.mas_centerY).with.offset(-5);
            make.height.equalTo(@15);
        }];

//        
    }
    
    if ([inboxrows.containAttach isEqualToString:@"0"]) {
        self.annexImage.hidden = YES;
    }else{
        self.annexImage.hidden = NO;
        
    }
    
}
@end
