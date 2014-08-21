//
//  SyndromeViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/18.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "SyndromeViewController.h"
#import "timeLineViewController.h"
#import "SyndromeCell.h"

@interface SyndromeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *syndroms;
@property (strong, nonatomic) NSArray *syndromImages;

@end



@implementation SyndromeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.syndroms =[[NSArray alloc] initWithObjects:@"咳",@"鼻水",@"のど",@"頭痛",@"高熱",@"寒気", nil];
    /*
     self.syndromImages =[[NSArray alloc] initWithObjects:
                         @"kaze.gif",
                         @"kaze.gif",
                         @"kaze.gif",
                         @"kaze.gif",
                         @"kaze.gif",
                         @"kaze.gif",
                         nil];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table view method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SyndromeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SyndromeCell" forIndexPath:indexPath];
    cell.syndromeLabel.text = [self.syndroms objectAtIndex:indexPath.row];
    //[cell.iconImage setImage:[UIImage imageNamed:[self.syndromImages objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    timeLineViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"timeLineViewController"];
    NSString *syndrome = [self.syndroms objectAtIndex:indexPath.row];
    controller.tweetquery = syndrome;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
