//
//  ThemeTextView.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeTextView : UITextView
@property(nonatomic,assign)CGFloat textFont;
- (id)initWithTextFont:(CGFloat )textFont;
@end
