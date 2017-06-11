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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
