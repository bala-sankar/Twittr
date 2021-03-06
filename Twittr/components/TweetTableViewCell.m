//
//  TweetTableViewCell.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/30/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <DateTools/NSDate+DateTools.h>
#import <UIImageView+AFNetworking.h>
#import "NavigationManager.h"

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UIView *contentContainer;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapImage)];
    [self.profileImageView addGestureRecognizer:imageTap];
    
    UITapGestureRecognizer *contentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapTweet)];
    [self.contentContainer addGestureRecognizer:contentTap];
    
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
    if (self.tweet.author.imageUrl != nil) {
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.tweet.author.imageUrl]];
    
        [self.profileImageView setImageWithURLRequest:imageRequest
                                 placeholderImage:nil
                                          success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                         // imageResponse will be nil if the image is cached
                                         if (response != nil) {
                                             NSLog(@"Image was NOT cached, fade in image");
                                             self.profileImageView.alpha = 0.0;
                                             self.profileImageView.image = image;
                                             [UIView animateWithDuration:0.3 animations:^{
                                                 self.profileImageView.alpha = 1.0;
                                             }];
                                         }
                                         else
                                         {
                                             NSLog(@"Image was cached so just update the image");
                                             self.profileImageView.image = image;
                                         }
                                         
                                     }
                                          failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                         nil;
                                     }];
    }
    
    if (self.tweet.retweet) {
        self.retweetContainerHeightConstraint.constant = 15;
        self.retweetLabel.text = [NSString stringWithFormat:@"%@ retweeted",self.tweet.user.screenName];
    } else {
        self.retweetContainerHeightConstraint.constant = 0;
    }
    [self.contentView setNeedsUpdateConstraints];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)onTapTweet {
    [self.delegate didTapTweet:self Tweet:self.tweet];
}

- (void)onTapImage {
    [self.delegate didTapImage:self User:self.tweet.author];
}

@end
