//
//  User.h
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *screenName;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *tagLine;
@property (nonatomic,strong) NSString *followersCount;
@property (nonatomic,strong) NSString *friendsCount;
@property (nonatomic,strong) NSString *tweetsCount;
@property (nonatomic,strong) NSString *backgroudImageUrl;

@property (class, nonatomic, assign, readonly) UserModel *currentUser;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
- (void)saveCurrentUserData;

@end
