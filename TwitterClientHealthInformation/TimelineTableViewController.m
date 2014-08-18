//
//  TimelineTableViewController.m
//  TwitterClientHealthInformation
//
//  Created by 有村 琢磨 on 2014/08/18.
//  Copyright (c) 2014年 有村 琢磨. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "STTwitterAPI.h"

@interface TimelineTableViewController ()
{
 NSMutableArray *postsArray;
 STTwitterAPI   *twitterAPIClient;
}
- (void)logintwitter;
- (void)getUserstream;

@end

#define kCONSUMER_KEY @"*********************"
#define kCONSUMER_SEC @"*********************"
#define kOAUTH_TOK    @"*********************"
#define kOAUTH_SEC    @"*********************"

@implementation TimelineTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loginTwitter
{
    twitterAPIClient = [STTwitterAPI twitterAPIWithOAuthConsumerName:nil
                                                         consumerKey:kCONSUMER_KEY
                                                      consumerSecret:kCONSUMER_SEC
                                                          oauthToken:kOAUTH_TOK
                                                    oauthTokenSecret:kOAUTH_SEC];
    [twitterAPIClient verifyCredentialsWithSuccessBlock:^(NSString *username) {
        // ログイン成功
        NSLog(@"granted");
        //[self getTimeline];
        //[self getUserStream];
    } errorBlock:^(NSError *error) {
        // ログイン失敗
        NSLog(@"error : %@", error);
    }];
}

- (void)getUserStream
{
    [twitterAPIClient getUserStreamDelimited:nil
                               stallWarnings:nil
         includeMessagesFromFollowedAccounts:nil
                              includeReplies:nil
                             keywordsToTrack:nil
                       locationBoundingBoxes:nil
                               progressBlock:^(id response) {
                                   // 取得成功
                                   NSLog(@"progress");
                                   [postsArray addObject:response];
                                   
                               } stallWarningBlock:^(NSString *code, NSString *message, NSUInteger percentFull) {
                                   NSLog(@"stall");
                                   
                               } errorBlock:^(NSError *error) {
                                   NSLog(@"error");
                               }];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
