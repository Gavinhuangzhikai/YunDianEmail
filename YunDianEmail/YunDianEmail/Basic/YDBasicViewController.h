//
//  YDBasicViewController.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDBasicViewController : UIViewController
@property (nonatomic, strong) MBProgressHUD *hud;

- (void)initParameters; // 参数初始化
- (void)initUIView; // 页面UI初始化
- (void)getDataFromNet; // 网络数据请求

- (void)setRefreshControl:(UIScrollView *)scrollView flag:(NSString *)flag; // 集成刷新控件
- (void)setUploadControl:(UIScrollView *)scrollView; // 集成加载控件
- (void)refreshAction; // 刷新调用
- (void)uploadAction; // 加载调用

@end
