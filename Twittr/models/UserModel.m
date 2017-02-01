//
//  User.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.imageUrl = dictionary[@"profile_image_url"];
        self.tagLine = dictionary[@"description"];
    }
    return self;
}

@end
