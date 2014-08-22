//
//  timeLineViewController.h
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/19.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesViewController.h"

@interface timeLineViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *tweetquery;
-(IBAction)refreshButton:(id)sender;

@end
