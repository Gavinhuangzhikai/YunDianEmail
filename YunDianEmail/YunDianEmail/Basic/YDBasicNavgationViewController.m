//
//  YDBasicNavgationViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicNavgationViewController.h"

@interface YDBasicNavgationViewController ()

@end

@implementation YDBasicNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.barTintColor = YDRGB(0, 112, 204);
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavgation
{
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        UIButton *backBtn=[UIButton  buttonWithType:UIButtonTypeCustom ];
        backBtn.frame = CGRectMake(0, 0, 15, 20);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_返回"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backBtn];

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark - ---------------- 事件 ------------------
#pragma mark - 返回
- (void)backAction
{
    [self popViewControllerAnimated:YES];
}

@end
