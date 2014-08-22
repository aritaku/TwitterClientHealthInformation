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

#define NANAPI_API_URL @"http://api.nanapi.jp/v1/recipeSearchDetails/?key=4cb94f0895324&format=json&top_theme_id=614"


@implementation ArticlesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"nanapi記事";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    [self getJson];
    
}

- (void) getJson
{
    NSString *path = [NSString stringWithFormat:@"%@&query=%@", NANAPI_API_URL, [NSString stringWithFormat:@"風邪 %@", self.query]];
    NSString* escaped = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escaped];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell" forIndexPath:indexPath];
    
    UIImageView *articleImageView = (UIImageView *)[cell viewWithTag:1 ];
    UITextView *articleTitleView = (UITextView *)[cell viewWithTag:2];
    UITextView *articleDescription = (UITextView * )[cell viewWithTag:3];
    
    NSString *title = [[self.nanapiList objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *description = [[self.nanapiList objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    NSString *articleImagePath = [[self.nanapiList objectAtIndex:indexPath.row] objectForKey:@"image"];
    NSURL *articleImagePathUrl = [[NSURL alloc] initWithString:articleImagePath];
    NSData *articleImagePathData = [[NSData alloc] initWithContentsOfURL:articleImagePathUrl];
    articleImageView.image = [[UIImage alloc] initWithData:articleImagePathData];
    
    articleTitleView.text = title;
    articleDescription.text = description;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = [[self.nanapiList objectAtIndex:indexPath.row] objectForKey:@"url"];
//    NSURL *url = [NSURL URLWithString:path];
//    [[UIApplication sharedApplication] openURL:url];
    
     nanapiViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"nanapiViewController"];
          
     //記事URLをnanapiViewControllerに渡す
    controller.articleURL = path;
    
    [self.navigationController pushViewController:controller animated:YES];

}

@end
