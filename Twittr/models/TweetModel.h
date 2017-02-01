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

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)convertTweets: (NSArray *)array;

@end
