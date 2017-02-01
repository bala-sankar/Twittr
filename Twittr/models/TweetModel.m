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
        self.text = dictionary[@"text"];
        self.author = [[UserModel alloc] initWithDictionary: dictionary[@"user"]];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEE MMM d HH:mm::ss Z y";
        self.createdAt = [dateFormatter dateFromString:createdAtString];
    }
    return self;
}

@end
