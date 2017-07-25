//
//  ViewController.h
//  PayDemo
//
//  Created by 张毅 on 19/07/2017.
//  Copyright © 2017 张毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "JSONKit.h"


@interface ViewController : UIViewController<NSURLConnectionDelegate, WKNavigationDelegate>

@property (nonatomic, retain) IBOutlet UIButton *wechatBtn;

@property (nonatomic, retain) IBOutlet UIButton *aliPayBtn;

@property (nonatomic, retain) WKWebView *mWebView;


-(IBAction)wechatPayClicked:(id)sender;

-(IBAction)aliPayClicked:(id)sender;
@end

