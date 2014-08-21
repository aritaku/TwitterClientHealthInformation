//
//  timeLineViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/19.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "timeLineViewController.h"
#import "STTwitterAPI.h"
#import "ArticlesViewController.h"

@interface timeLineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) STTwitterAPI *twitter;

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *accessTokenSecret;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *twitterFeed;

@property (strong, nonatomic) ArticlesViewController *query;

@end

#define kConsumerName @"twitterHealthinformation"
#define kConsumerKey @"EhhuYaRduMyFUuCKVBGM0EJv2"
#define kConsumerKeySecret @"w5rkamurSb0PgConK96PsM5WMgzGsuuhj94k6hwOxchn8RFMKa"


@implementation timeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
	// Do any additional setup after loading the view, typically from a nib.
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:kConsumerName
                                                     consumerKey:kConsumerKey
                                                  consumerSecret:kConsumerKeySecret];
    [self.twitter postReverseOAuthTokenRequest:^(NSString *authenticationHeader) {
        self.twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
    } errorBlock:^(NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
    
    //検索クエリの取得
    //あとで動的にする
    NSString *str = _query;
    [self.twitter getSearchTweetsWithQuery:@"風邪 && 咳"
                              successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
                                  self.twitterFeed = [[NSMutableArray alloc] initWithArray:statuses];
                                  [self.tableView reloadData];
                              } errorBlock:^(NSError *error) {
                                  NSLog(@"%@", error);
                              }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


#pragma mark Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.twitterFeed.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tweetcell =  @"Tweetcell" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tweetcell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tweetcell];
    }
    
    NSInteger idx = indexPath.row;
    NSDictionary *t = self.twitterFeed[idx];
    
    cell.textLabel.text = t[@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticlesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
    controller.query = @"咳";
    [self.navigationController pushViewController:controller animated:YES];
//    //タップを感知してツイート本文を取得
//    //TODO: 最終的に動的にnanapiAPIのqueryに渡すワードを生成する
////   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetcell" forIndexPath:indexPath];
//
//    //ツイート本文よりキーワードを取得
////    NSString *tweetMessage = cell.textLabel.text;
//    NSString *queryWord = @"咳";
//    ArticleTextViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleTextViewController"];
//    
//    //キーワードをArtileTextViewControlerに渡す
//    controller.query = queryWord;
//
//    // 実際に画面遷移を命令している部分（アニメーション付きで）
//    [self.navigationController pushViewController:controller animated:YES];
//    
}


@end
