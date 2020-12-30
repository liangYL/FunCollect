//
//  JSWebViewController.m
//  
//
//  Created by liang on 16/5/17.
//
//

#import "JSWebViewController.h"
#import <WebKit/WebKit.h>
@interface JSWebViewController ()

@end

@implementation JSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
 
    
    
//    if([_urlTitle isEqualToString:@"下雨动画"]||[_urlTitle isEqualToString:@"拼图动画"]||[_urlTitle isEqualToString:@"云朵效果"]){
        UIWebView * webView = [[UIWebView alloc] init];
        webView.scalesPageToFit = YES;
        [self.view addSubview:webView];
        
        [webView setMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
        [webView release];
        
        //加载网页
        NSURL *url = [[NSBundle mainBundle] URLForResource:_urlTitle withExtension:@"html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        
//    }else{
//        //ios8以后省内存
//        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.lyWidth, self.view.lyHeight-64)];
//        [self.view addSubview:webView];
//        
//        //加载网页
//        NSURL *url = [[NSBundle mainBundle] URLForResource:_urlTitle withExtension:@"html"];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//    }
//    
    
    
    
    
}







- (void)dealloc
{
    [super dealloc];
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
