//
//  TweetModel.h
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface TweetModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) UserModel *author;
@property (nonatomic, assign) BOOL retweet;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) NSString *favoriteCount;
@property (nonatomic, strong) NSString *retweetCount;

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)convertTweets: (NSArray *)array;

@end
