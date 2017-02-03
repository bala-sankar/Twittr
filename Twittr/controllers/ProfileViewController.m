//
//  ProfileViewController.m
//  Twittr
//
//  Created by Balachandar Sankar on 2/1/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bacgroundImageViewTopConstraint;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshData {
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.bioLabel.text = self.user.tagLine;
    
    if (self.user.imageUrl != nil) {
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.user.imageUrl]];
        
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

    if (self.user.backgroudImageUrl != nil) {
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.user.backgroudImageUrl]];
        
        [self.backgroudImageView setImageWithURLRequest:imageRequest
                                     placeholderImage:nil
                                              success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                  // imageResponse will be nil if the image is cached
                                                  if (response != nil) {
                                                      NSLog(@"Image was NOT cached, fade in image");
                                                      self.backgroudImageView.alpha = 0.0;
                                                      self.backgroudImageView.image = image;
                                                      [UIView animateWithDuration:0.3 animations:^{
                                                          self.backgroudImageView.alpha = 1.0;
                                                      }];
                                                  }
                                                  else
                                                  {
                                                      NSLog(@"Image was cached so just update the image");
                                                      self.backgroudImageView.image = image;
                                                  }
                                                  
                                              }
                                              failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                  nil;
                                              }];
    }

    self.bacgroundImageViewTopConstraint.constant = self.navigationController.navigationBar.frame.size.height;
    self.tweetCount.text = [NSString stringWithFormat:@"%@ Tweets", self.user.tweetsCount];
    self.followerCount.text = [NSString stringWithFormat:@"%@ Followers", self.user.followersCount];
    self.followingCount.text = [NSString stringWithFormat:@"%@ Following", self.user.friendsCount];
    [self.view setNeedsUpdateConstraints];    
}

@end
