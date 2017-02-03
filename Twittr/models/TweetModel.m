//
//  TweetModel.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "TweetModel.h"

@implementation TweetModel

-(instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        bool isRetweet = (dictionary[@"retweeted_status"] != nil);
        NSDictionary *fields = dictionary;
        self.retweet = NO;
        if (isRetweet) {
            fields = dictionary[@"retweeted_status"];
            self.retweet = YES;
        }
        self.text = fields[@"text"];
        self.author = [[UserModel alloc] initWithDictionary: fields[@"user"]];
        self.user = [[UserModel alloc] initWithDictionary: dictionary[@"user"]];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [dateFormatter dateFromString:createdAtString];
    }
    return self;
}

+ (NSArray *)convertTweets: (NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[self alloc] initWithDictionary:dictionary]];
    }
    return tweets;
}

@end
