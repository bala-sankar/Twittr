//
//  TweetListViewController.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/30/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TweetListViewController.h"

@interface TweetListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tweetListTableView;

@end

@implementation TweetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetListTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
