//
//  SyndromeViewController.h
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/18.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "timeLineViewController.h"

@interface SyndromeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *tweetquery;

@end

