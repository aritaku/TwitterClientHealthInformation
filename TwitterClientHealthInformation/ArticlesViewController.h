//
//  ArticlesViewController.h
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/20.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *query;

@end
