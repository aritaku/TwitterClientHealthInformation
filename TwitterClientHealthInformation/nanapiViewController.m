//
//  nanapiViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/20.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "nanapiViewController.h"

@interface nanapiViewController ()

@end

@implementation nanapiViewController
{
    NSURLAuthenticationChallenge *authChallenge;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // URLから、URLリクエストを作成する。
    NSURL *url = [NSURL URLWithString:self.articleURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    // WebViewに開きたいURLを設定する
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//アクションメニュー
- (IBAction)actionButtonDidPush:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Actions" delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"Safariで開く",nil];
    [as showFromToolbar:self.toolBar];
}

//UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
            //javascriptでdocument.URLを取得し、Safariで開く
            NSString *urlString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];

}

//UIWebViewDelegate

//UIwebViewが読み込みを開始
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressView.progress = 0.1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
// UIWebViewが読み込みを終了
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.progressView.progress = 1.0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // JavaScriptを用いてタイトルを取得する
    self.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

// UIWebViewで読み込みが失敗
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.progressView.progress = 0.0;
    if (error.code != NSURLErrorCancelled) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"読み込みに失敗しました。" message:error.localizedDescription  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}




@end
