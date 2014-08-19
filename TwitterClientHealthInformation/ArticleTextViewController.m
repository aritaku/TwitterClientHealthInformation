//
//  ArticleTextViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/19.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "ArticleTextViewController.h"


@interface ArticleTextViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ArticleTextViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        timeLineViewController *atvc = [[timeLineViewController alloc] initWithNibName:@"timelineViewController" bundle:nil];
        [self.navigationController pushViewController:atvc
                                             animated:YES];
    }
}


/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
