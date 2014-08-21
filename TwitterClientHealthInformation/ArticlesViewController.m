//
//  ArticlesViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/20.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "ArticlesViewController.h"
#import "nanapiViewController.h"

@interface ArticlesViewController ()

@property(strong, nonatomic) NSMutableArray *nanapiList;

@end

#define NANAPI_API_URL @"http://api.nanapi.jp/v1/recipeSearchDetails/?key=4cb94f0895324&format=json&top_theme_id=614&query=%E5%92%B3"


@implementation ArticlesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getJson];
    
}

- (void) getJson
{
    NSURL *url = [NSURL URLWithString:NANAPI_API_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                           // jsonデータをNSDictへ
                                           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                           //リスト管理するプロパティに挿入
                                           self.nanapiList = [[dict objectForKey:@"response"] objectForKey:@"recipes"];
                                           //データ取得後テーブルを再描画
                                           [self.tableView reloadData];
                                           
                                       }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nanapiList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *title = [[self.nanapiList objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = [[self.nanapiList objectAtIndex:indexPath.row] objectForKey:@"url"];
    NSURL *url = [NSURL URLWithString:path];
    [[UIApplication sharedApplication] openURL:url];
    
    /*
     UIPageViewController *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"nanapiViewController"];
     //タップを感知して記事URLを取得
     UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
     
     [self.view  addGestureRecognizer:singleTapGestureRecognizer];
     
     //記事URLをnanapiViewControllerに渡す
     controller.articleUrl =path;
     
     [self.navigationController pushViewController:controller2 animated:YES];
     */

}

@end
