//
//  timeLineViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/19.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "timeLineViewController.h"
#import "STTwitterAPI.h"

@interface timeLineViewController ()

@property (nonatomic, strong) STTwitterAPI *twitter;

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *accessTokenSecret;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *twitterFeed;


@end

#define kConsumerName @"twitterHealthinformation"
#define kConsumerKey @"EhhuYaRduMyFUuCKVBGM0EJv2"
#define kConsumerKeySecret @"w5rkamurSb0PgConK96PsM5WMgzGsuuhj94k6hwOxchn8RFMKa"


@implementation timeLineViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:kConsumerName
                                                     consumerKey:kConsumerKey
                                                  consumerSecret:kConsumerKeySecret];
    [self.twitter postReverseOAuthTokenRequest:^(NSString *authenticationHeader) {
        self.twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
        [self.twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            [self.twitter postReverseAuthAccessTokenWithAuthenticationHeader:authenticationHeader
                                                                successBlock:^(NSString *oAuthToken,
                                                                               NSString *oAuthTokenSecret,
                                                                               NSString *userID,
                                                                               NSString *screenName) {
                                                                    self.accessToken = oAuthToken;
                                                                    self.accessTokenSecret = oAuthTokenSecret;
                                                                    NSLog(@"Token %@ secret %@",oAuthToken,oAuthTokenSecret);
                                                                    
                                                                } errorBlock:^(NSError *error) {
                                                                    NSLog(@"error %@",[error description]);
                                                                    
                                                                }];
        } errorBlock:^(NSError *error) {
            NSLog(@"error %@",[error description]);
        }];
    } errorBlock:^(NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
    //検索クエリの取得
    [self.twitter getSearchTweetsWithQuery:@"かぜ"
                              successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
                                  NSLog(@"%@ %@", searchMetadata, statuses);
                              } errorBlock:^(NSError *error) {
                                  NSLog(@"%@", error);
                              }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
