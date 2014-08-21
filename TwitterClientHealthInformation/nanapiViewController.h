//
//  nanapiViewController.h
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/20.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nanapiViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButtonitem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButtonItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (strong, nonatomic) NSString *articleURL;

- (IBAction)actionButtonDidPush:(id)sender;


@end
