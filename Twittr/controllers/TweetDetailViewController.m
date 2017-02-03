//
//  TweetDetailViewController.m
//  Twittr
//
//  Created by Balachandar Sankar on 2/1/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TweetDetailViewController.h"
#import <UIImageView+AFNetworking.h>


@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLavel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightConstraint;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshData {
    self.authorNameLabel.text = self.tweet.author.name;
    self.authorHandleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.author.screenName];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:self.tweet.createdAt];
    
    self.dateLavel.text=formattedDateString;
    self.tweetContentLabel.text = self.tweet.text;
    if (self.tweet.author.imageUrl != nil) {
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.tweet.author.imageUrl]];
        
        [self.authorProfileImageView setImageWithURLRequest:imageRequest
                                     placeholderImage:nil
                                              success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                  // imageResponse will be nil if the image is cached
                                                  if (response != nil) {
                                                      NSLog(@"Image was NOT cached, fade in image");
                                                      self.authorProfileImageView.alpha = 0.0;
                                                      self.authorProfileImageView.image = image;
                                                      [UIView animateWithDuration:0.3 animations:^{
                                                          self.authorProfileImageView.alpha = 1.0;
                                                      }];
                                                  }
                                                  else
                                                  {
                                                      NSLog(@"Image was cached so just update the image");
                                                      self.authorProfileImageView.image = image;
                                                  }
                                                  
                                              }
                                              failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                  nil;
                                              }];
    }
    
    if (self.tweet.retweet) {
        self.retweetContainerHeightConstraint.constant = 15;
        self.retweetedLabel.text = [NSString stringWithFormat:@"%@ Retweeted",self.tweet.user.name];
    } else {
        self.retweetContainerHeightConstraint.constant = 0;
    }
    self.retweetContainerTopConstraint.constant = self.navigationController.navigationBar.frame.size.height + 30;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%@ Likes", self.tweet.favoriteCount];
    self.retweetsCountLabel.text = [NSString stringWithFormat:@"%@ Retweets", self.tweet.retweetCount];
    [self.view setNeedsUpdateConstraints];    
}


@end
