//
//  ArticleCell.h
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/22.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *articleImageView;
@property (strong, nonatomic) IBOutlet UILabel *articleTitile;
@property (strong, nonatomic) IBOutlet UITextView *articleDescription;

@end
