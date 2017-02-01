//
//  TweetTableViewCell.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/30/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <DateTools/NSDate+DateTools.h>
#import <AFNetworking/UIImage+AFNetworking.h>

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self refreshData];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) refreshData {
    self.nameLabel.text = self.tweet.author.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.author.screenName];
    self.timestampLabel.text=self.tweet.createdAt.shortTimeAgoSinceNow;
    self.contentLabel.text = self.tweet.text;
//    self.profileImageView = self.tweet.author.imageUrl;
}

@end
