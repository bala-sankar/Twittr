//
//  TweetListViewController.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/30/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "TweetModel.h"

@interface TweetListViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tweetListTableView;
@property (strong, nonatomic) NSArray *tweetModels;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetListTableView.dataSource = self;
    self.tweetListTableView.estimatedRowHeight = 200;
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tweetListTableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
    
    [self fetchTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchTweets {
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json"
                             parameters:nil
                               progress:^(NSProgress * _Nonnull downloadProgress) {
                                   NSLog(@"Request to fetch tweets in progress");
                               }
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"Retrieved tweets successfully");
                                    self.tweetModels = [TweetModel convertTweets:responseObject];
                                    [self.tweetListTableView reloadData];
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"Failed to retireve tweets");
                                }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    cell.tweet = [self.tweetModels objectAtIndex:indexPath.row];
    [cell refreshData];
    return cell;
}


@end
