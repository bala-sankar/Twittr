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

- (void) refreshData;

@end
