//
//  YDViewAttachmentsViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/25.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDViewAttachmentsViewController.h"
#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>

@interface YDViewAttachmentsViewController ()<UIWebViewDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>
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
{
    self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];
    [self isSavedFileToLocalWithfileName:self.emailFileModel.filename];
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
        _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: _webView];
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


- (void)attachmentsRequestwithURL:(NSString *)urlString  withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest download:urlString parameters:dictionary success:^(id responseObj) {
          [self.hud hideAnimated:YES];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", self.emailFileModel.filename]];
         NSURL *url = [NSURL fileURLWithPath:path];
        [self.webView loadFileURL:url allowingReadAccessToURL:url];
        
    } failure:^(NSError *error) {
            [YDTools loadFailedHUD:self.hud text:@"加载失败" ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });

    }];
    

    


}

- (void)analyseData:(id)responseObj
{

    
}


- (void)isSavedFileToLocalWithfileName:(NSString *)fileName
{
    // 判断是否已经离线下载了
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];

    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    if ([filemanager fileExistsAtPath:path]) {
          [self.hud hideAnimated:YES];
        NSURL *url = [NSURL fileURLWithPath:path];
        [self.webView loadFileURL:url allowingReadAccessToURL:url];

        
    }else{
        
        NSDictionary *dataDic = @{@"fileId":_emailFileModel.ID};
        [self attachmentsRequestwithURL:YDEmailFileDownloadUrl withDictionary:dataDic];
    }
}



@end
