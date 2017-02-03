//
//  User.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "UserModel.h"

@interface UserModel()

@property (nonatomic, strong) NSDictionary *userDataDictionary;

@end

@implementation UserModel

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.imageUrl = dictionary[@"profile_image_url"];
        self.tagLine = dictionary[@"description"];
        self.followersCount = dictionary[@"followers_count"];
        self.friendsCount = dictionary[@"friends_count"];
        self.tweetsCount = dictionary[@"statuses_count"];
        self.backgroudImageUrl = dictionary[@"profile_banner_url"];
        self.location = dictionary[@"location"];
        
        self.userDataDictionary = dictionary;
    }
    return self;
}

- (void)saveCurrentUserData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.userDataDictionary] forKey:@"current_user_data"];
    [defaults synchronize];
}

+ (UserModel *)currentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"current_user_data"];
    NSDictionary *dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (dictionary != nil) {
        return [[UserModel alloc] initWithDictionary:dictionary];
    }
    return nil;
}

@end
