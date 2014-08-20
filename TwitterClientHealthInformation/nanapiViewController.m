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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIWebView *webView = [UIWebView new];
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
