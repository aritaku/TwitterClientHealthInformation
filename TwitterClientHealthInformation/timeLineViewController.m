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

@property (strong, nonatomic) NSMutableArray *twitterFeed;
@property (strong, nonatomic) NSArray *syndroms;

@end

#define kConsumerName @"twitterHealthinformation"
#define kConsumerKey @"EhhuYaRduMyFUuCKVBGM0EJv2"
#define kConsumerKeySecret @"w5rkamurSb0PgConK96PsM5WMgzGsuuhj94k6hwOxchn8RFMKa"


@implementation timeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ツイート";
    
    [self twitterTimeline];
}

- (IBAction)refreshButton:(id)sender
{
    [self twitterTimeline];
}

- (void)twitterTimeline
{
    
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
    [self.twitter getSearchTweetsWithQuery:[NSString stringWithFormat:@"風邪 AND %@", self.tweetquery]
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
    
    UITextView *tweetTextView = (UITextView *)[cell viewWithTag:3];
    UILabel *userLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *userIdLabel = (UILabel *)[cell viewWithTag:2];
    UIImageView *userImageView = (UIImageView *)[cell viewWithTag:4];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tweetcell];
    }
    
    NSInteger idx = indexPath.row;
    NSDictionary *tweet = self.twitterFeed[idx];
    NSDictionary *userInfo = tweet[@"user"];
    
    //cell.textLabel.text = tweet[@"text"];
    tweetTextView.text = [NSString stringWithFormat:@"%@", tweet[@"text"]];
    userLabel.text = [NSString stringWithFormat:@"%@", userInfo[@"name"]];
    userIdLabel.text = [NSString stringWithFormat:@"%@", userInfo[@"screen_name"]];
    
    NSString *userImagePath = userInfo[@"profile_image_url"];
    NSURL *userImagePathUrl = [[NSURL alloc] initWithString:userImagePath];
    NSData *userImagePathData = [[NSData alloc] initWithContentsOfURL:userImagePathUrl];
    userImageView.image = [[UIImage alloc] initWithData:userImagePathData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticlesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesViewController"];
    controller.query = self.tweetquery;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
