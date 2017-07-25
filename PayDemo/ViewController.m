//
//  ViewController.m
//  PayDemo
//
//  Created by 张毅 on 19/07/2017.
//  Copyright © 2017 张毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.mWebView.navigationDelegate = self;
    [self.view addSubview:self.mWebView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma WeChat Pay

-(IBAction)wechatPayClicked:(id)sender {
    NSURL *get_ticket_url = [NSURL URLWithString:@"https://pullmi.cn/wx/payDemo.do"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:get_ticket_url];
    NSHTTPURLResponse *resp;
//    [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&resp error:nil];
//    [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *resp = [data objectFromJSONData];
            NSLog(@"%@", [resp objectForKey:@"obj"]);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[resp objectForKey:@"obj"]] options:nil completionHandler:nil];
        }
    }];

    NSLog(@"%@", resp);
}

-(IBAction)aliPayClicked:(id)sender {
    NSURL *get_ticket_url = [NSURL URLWithString:@"https://pullmi.cn/wx/aliPayDemo.do"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:get_ticket_url];
    NSHTTPURLResponse *resp;
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *resp = [data objectFromJSONData];
            NSLog(@"%@", [resp objectForKey:@"code"]);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[resp objectForKey:@"obj"] objectForKey:@"code"]]];
            NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
            NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
            request.allHTTPHeaderFields = requestHeaderFields;
            [self.mWebView loadRequest:request];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[connectionError description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

-(void) webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSString *urlStr = [navigationResponse.response.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([urlStr containsString:@"alipays://"]) {
        NSRange range = [urlStr rangeOfString:@"alipays://"];
        NSString * resultStr = [urlStr substringFromIndex:range.location];
    
        NSURL *alipayURL = [NSURL URLWithString:resultStr];
        [[UIApplication sharedApplication] openURL:alipayURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
            
        }];
        
    }
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    decisionHandler(actionPolicy);
}

@end
