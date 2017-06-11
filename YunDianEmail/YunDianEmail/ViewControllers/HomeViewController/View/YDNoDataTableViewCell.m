//
//  YDNoDataTableViewCell.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/10.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDNoDataTableViewCell.h"


@interface YDNoDataTableViewCell ()

@property (nonatomic, strong) UILabel *label;


@end
@implementation YDNoDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createInterface];
    }
    return self;
}
- (void)createInterface
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];

    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, self.width, 20)];
    _label.text = @"暂无邮件";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor darkGrayColor];
    _label.font = YDFont(14);
    [self.contentView addSubview:self.label];
}



@end
