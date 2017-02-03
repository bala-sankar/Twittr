//
//  NavigationManager.h
//  Twittr
//
//  Created by Balachandar Sankar on 2/1/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TweetViewType) {
    TweetViewTypeLogin,
    TweetViewTypeHome,
    TweetViewTypeMentions,
    TweetViewTypeProfile,
    TweetViewTypeCreate,
    TweetViewTypeDetail
    
};

@interface NavigationManager : NSObject

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (instancetype)sharedInstance;

- (void)login;
- (void)logout;
- (void)pushView:(TweetViewType) tweetViewType;

@end
