//
//  TweetTableViewCell.h
//  Twittr
//
//  Created by Balachandar Sankar on 1/30/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetModel.h"

@interface TweetTableViewCell : UITableViewCell

@property (nonatomic, strong) TweetModel *tweet;
@property (weak, nonatomic) id delegate;

- (void) refreshData;

@end

@protocol TweetTableViewCellDelegate<NSObject>

- (void)didTapTweet:(TweetTableViewCell *)tableViewCell Tweet:(TweetModel *)tweet;
- (void)didTapImage:(TweetTableViewCell *)tableViewCell User:(UserModel *)user;

@end


