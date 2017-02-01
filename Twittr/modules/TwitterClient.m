//
//  TwitterClient.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"l3RPoWnTwVRvbAuClXuYwlWUq";
NSString * const kTwitterConsumerSecret = @"WxWb2jEOU9SfyrEchK7GoyRnyWlN1Nqy3ioziirEKKl7UATszg";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com/";

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion)(UserModel *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)getInstance {
    static TwitterClient *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

- (void)loginWithCompletion:(void (^)(UserModel *user, NSError *error))completion
{
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twittr://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got the request token");
        
        NSURL *authUrl = [NSURL URLWithString:[ NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        
        [[UIApplication sharedApplication] openURL:authUrl options:[NSDictionary new] completionHandler:^(BOOL success) {
            NSLog(@"Authorize url called");
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get a request token");
        self.loginCompletion(nil, error);
    }];

}

- (void)openUrl:(NSURL *)url
{
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got the access token");
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json"
                              parameters:nil
                                progress:^(NSProgress * _Nonnull downloadProgress) {
                                    NSLog(@"Request in progress");
                                }
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     UserModel * user = [[UserModel alloc] initWithDictionary:responseObject];
                                     NSLog(@"Request is successful. Current user: %@", user.name);
                                     self.loginCompletion(user, nil);
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     NSLog(@"Request failed");
                                     self.loginCompletion(nil, error);
                                 }];
    } failure:^(NSError *error) {
        NSLog(@"Failed to get a access token");
        self.loginCompletion(nil, error);
    }];
}

@end
