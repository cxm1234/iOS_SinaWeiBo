//
//  XMOAuthViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/9.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMOAuthViewController.h"
#import "XMNewfeatureController.h"
#import "XMTabBarViewController.h"
#import "AFNetworking.h"
#import "XMAccount.h"
#import "XMAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface XMOAuthViewController ()<UIWebViewDelegate>

@end

@implementation XMOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.delegate=self;
    webView.frame=self.view.bounds;
    [self.view addSubview:webView];
    
    /*
     http://api.t.sina.com.cn/oauth/authorize
     */
    NSURL *url=[NSURL URLWithString:@"https://api.t.sina.com.cn/oauth2/authorize?client_id=781428218&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在登录中..."];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    XMLog(@"shouldStartLoadWithRequest---%@",request.URL.absoluteString);
    
    NSString *url=request.URL.absoluteString;
    
    //判断是否为回调地址
    NSRange range=[url rangeOfString:@"code="];
    
    if(range.length!=0){
        int fromIndex=range.location+range.length;
        NSString *code=[url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
//        XMLog(@"%@",code);
        //不要加载回调地址
        return NO;
    }
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    params[@"client_id"]=@"781428218";
    params[@"client_secret"]=@"c7f1a85089cad1407559284a72db0f76";
    params[@"grant_type"]=@"authorization_code";
    params[@"redirect_uri"]=@"http://www.baidu.com";
    params[@"code"]=code;
    
    
    [mgr POST:@"https://api.t.sina.com.cn/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary  *responseObject) {
        [MBProgressHUD hideHUD];
        XMLog(@"请求成功--%@",responseObject);
        
        XMAccount *account=[XMAccount accountWithDict:responseObject];
        [XMAccountTool saveAccount:account];
        
        //切换窗口的根控制器,自动判断版本是否需要更新
        
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        XMLog(@"请求失败-%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
