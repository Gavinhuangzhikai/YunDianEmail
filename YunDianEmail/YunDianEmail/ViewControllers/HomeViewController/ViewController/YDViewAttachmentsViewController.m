//
//  YDViewAttachmentsViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/25.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDViewAttachmentsViewController.h"
#import <WebKit/WebKit.h>


@interface YDViewAttachmentsViewController ()
@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic,strong) UIImageView *attcthImage;
@end

@implementation YDViewAttachmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ---------------- 初始化 -----------------
#pragma mark - 参数初始化
- (void)initParameters
{
    [super initParameters];
    
}

#pragma mark - 界面初始化
- (void)initUIView
{
    [super initUIView];
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{   NSDictionary *dataDic = @{@"ID":@"-2"};
    [self attachmentsRequestwithURL:YDEmailFileDownloadUrl ];
}

#pragma mark -创建控件
- (void)createInterface
{
 

    
}

#pragma mark - Layz init
- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
   
        config.preferences = [WKPreferences new];

        config.preferences.minimumFontSize = 10;
  
        config.preferences.javaScriptEnabled = YES;

        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
       _webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:config];
    }
    return _webView;
}

- (UIImageView *)attcthImage
{
    if (!_attcthImage) {
        _attcthImage = [[UIImageView alloc] init];
        _attcthImage.contentMode =  UIViewContentModeCenter;
    }
    return _attcthImage;
}


- (void)attachmentsRequestwithURL:(NSString *)urlString
{

    
    [YDHttpRequest download:urlString success:^(id responseObj) {
           [YDTools loadFailedHUD:self.hud text:@"加载失败" ];
    } failure:^(NSError * error) {
          [YDTools loadFailedHUD:self.hud text:@"加载失败" ];
    }];

}

- (void)analyseData:(id)responseObj
{

    
}


- (void)isSavedFileToLocalWithCreated:(UInt32)created fileName:(NSString *)fileName
{
    // 判断是否已经离线下载了
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d/%@", created, fileName]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    if ([filemanager fileExistsAtPath:path]) {
        NSURL *url = [NSURL URLWithString:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        
        NSDictionary *dataDic = @{@"ID":@"-2"};
        [self attachmentsRequestwithURL:YDEmailFileDownloadUrl];
    }
}



@end
