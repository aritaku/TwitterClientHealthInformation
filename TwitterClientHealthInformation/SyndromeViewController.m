//
//  SyndromeViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/18.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "SyndromeViewController.h"
#import "timeLineViewController.h"

@interface SyndromeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *syndroms;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) timeLineViewController *query;

@end

@implementation SyndromeViewController

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

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table view method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *syndroms =[[NSArray alloc] initWithObjects:@"咳",@"鼻水",@"のど",@"頭痛",@"高熱",@"寒気", nil];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier: @"cellid"];
    }
    NSInteger idx = indexPath.row;
    
    cell.textLabel.text = syndroms[idx];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    timeLineViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"timeLineViewController"];
    controller.query = cell.textLabel.text;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
