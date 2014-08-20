//
//  ArticleTextViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/19.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "ArticleTextViewController.h"


@interface ArticleTextViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSMutableArray *nanapiList;

@end

#define NANAPI_API_URL @"http://api.nanapi.jp/v1/recipeLookupDetails/?key=4cb94f0895324&format=json&theme_id=614&query=queryWord"

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

    //初期化
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //わたって来たキーワードをnanapiAPIに渡してコール
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


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *recipe = [self.nanapiList objectAtIndex:indexPath.row];
    cell.textLabel.text = [recipe objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIPageViewController *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"nanapiViewController"];
    //タップを感知して記事URLを取得
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    
    [self.  addGestureRecognizer:singleTapGestureRecognizer];
    
    //記事URLをnanapiViewControllerに渡す
    controller2.articleUrl =
    
    [self.navigationController pushViewController:controller2 animated:YES];
}

@end
