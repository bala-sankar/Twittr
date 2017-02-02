//
//  NavigationManager.m
//  Twittr
//
//  Created by Balachandar Sankar on 2/1/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "NavigationManager.h"
#import "UserModel.h"
#import "TweetListViewController.h"
#import "LoginViewController.h"

@interface NavigationManager()

@property (nonatomic, assign, readonly) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation NavigationManager

+ (instancetype)sharedInstance
{
    static NavigationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationManager alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isLoggedIn {
    return (UserModel.currentUser != nil);
}

- (UIViewController *)rootViewController {
    UIViewController *viewController;
    if (self.isLoggedIn) {
        viewController = [self mainTabViewController];
    } else {
        viewController = [self loginViewController];
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.navigationController.navigationBarHidden = YES;
    return self.navigationController;
}

- (UIViewController *)loginViewController {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return loginViewController;
}

- (UIViewController *)tweetViewController {
    TweetListViewController *tweetViewController = [[TweetListViewController alloc]
                                                    initWithNibName:@"TweetListViewController" bundle:nil];
    return tweetViewController;
}

- (UIViewController *)mainTabViewController {
    UIViewController *tweetNavigationController = [self tweetListNavigationController];
    
    // create tab item
    UITabBarItem *tweetListItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    tweetNavigationController.tabBarItem = tweetListItem;

    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    mainTabBarController.viewControllers = @[tweetNavigationController];
    return mainTabBarController;
}

- (UIViewController *)tweetListNavigationController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[self tweetViewController]];
    return navigationController;
}

@end
