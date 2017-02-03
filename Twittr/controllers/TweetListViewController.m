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
#import "NavigationManager.h"

@interface TweetListViewController () <UITableViewDataSource, TweetTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tweetListTableView;
@property (strong, nonatomic) NSArray *tweetModels;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];

    self.tweetListTableView.dataSource = self;
    self.tweetListTableView.estimatedRowHeight = 200;
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tweetListTableView registerNib:nib forCellReuseIdentifier:@"TweetTableViewCell"];
    self.tweetListTableView.showsVerticalScrollIndicator = NO;
    [self.view setNeedsUpdateConstraints];

    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tweetListTableView insertSubview:self.refreshControl atIndex:0];

    [self fetchTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchTweets {
    NSString *URLString = ([self.restorationIdentifier  isEqual: @"home"]) ? @"1.1/statuses/home_timeline.json" : @"1.1/statuses/mentions_timeline.json";
    [[TwitterClient sharedInstance] GET:URLString
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
                                    NSLog(@"Failed to retrieve tweets");
                                }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    cell.tweet = [self.tweetModels objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell refreshData];
    return cell;
}

- (void)didTapTweet:(TweetTableViewCell *)tableViewCell Tweet:(TweetModel *)tweet {
    [[NavigationManager sharedInstance] pushTweetDetailView:tweet];
    
}

- (void)didTapImage:(TweetTableViewCell *)tableViewCell User:(UserModel *)user {
     [[NavigationManager sharedInstance] pushProfileView:user];
}

- (void)onRefresh {
    [self.refreshControl beginRefreshing];
    [self fetchTweets];
    [self.refreshControl endRefreshing];
}

@end
