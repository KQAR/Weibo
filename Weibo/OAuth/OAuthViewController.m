//
//  OAuthViewController.m
//  Weibo
//
//  Created by he on 2018/10/13.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "OAuthViewController.h"
#import "RootTabBarController.h"
#import "NewFeatureViewController.h"
#import "ControllerTool.h"
#import "Account.h"
#import "AccountTool.h"
#import <WebKit/WebKit.h>

@interface OAuthViewController () <WKNavigationDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建UIWebView
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.加载登录页面
    NSURL *url = [NSURL URLWithString:URL_Login];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 3.设置代理
    webView.navigationDelegate = self;
}

#pragma mark - WKNavigationDelegate
/**
 *  WKWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

/**
 *  WKWebView加载完毕的时候调用(请求完毕)
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUD];
}

/**
 *  WKWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    // 1.获取请求地址
//    NSString *url = navigationAction.request.URL.host.lowercaseString;
    NSString *url = navigationAction.request.URL.absoluteString;
    JRLog(@"-----%@-----", url);
    NSString *str = [NSString stringWithFormat:@"%@?code=", RedirectURI];
    NSRange range = [url rangeOfString:str];
    /**
     * range.location 是地址开始的位置
     * range.length 是地址的长度
     */
    if (range.location != NSNotFound) {
        // 截图授权成功收的请求标记
        NSInteger from = range.location + range.length;
        NSString *code = [url substringFromIndex:from];
        JRLog(@"-- %@ --", code);
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调页面
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)accessTokenWithCode:(NSString *)code
{
    // 1.获取请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //  解决返回类型不兼容的问题(网络传输协议)
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = AppKey;
    params[@"client_secret"] = AppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = RedirectURI;  // 必须开发平台填写的回调地址一致，一个斜杠都不能少
    
    // 3.发送POST请求
    [manager POST:URL_access_token parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        // 字典转模型
        Account *account = [Account accountWithDict:responseObject];
        
        // 存储账号模型
        [AccountTool save:account];
        
        
        // 存储授权成功的账号信息
//        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *filepath = [doc stringByAppendingPathComponent:@"account.plist"];
        
//        [responseObject writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        //如果对象是NSString、NSDictionary、NSArray、NSData、 NSNumber等类型,就可以使用writeToFile:atomically:⽅法 直接将对象写到属性列表文件中 (把上面的 resposeObject 改成 NSDictionary 类型)
        
//        [responseObject writeToFile:filepath atomically:YES];
        
        // 切换控制器
        [ControllerTool chooseRootViewController];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        JRLog(@"请求失败---%@", error);
    }];
}

@end
