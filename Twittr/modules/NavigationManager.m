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
        viewController = [self tweetViewController];
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
//
//- (UIViewController *)loggedInVC
//{
//    // Create root VC for the tab's navigation controller
//    LoggedInViewController *vc = [[LoggedInViewController alloc] initWithNibName:@"LoggedInViewController" bundle:nil];
//    vc.title = @"Logged In";
//    
//    // create tab item
//    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Logged In" image:nil tag:0];
//    vc.tabBarItem = item;
//    
//    
//    // create navigation controller
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
//    
//    // create tab bar view controller
//    UITabBarController *tabController = [[UITabBarController alloc] init];
//    // Add navigation controller to tab bar controller
//    tabController.viewControllers = @[navController];
//    
//    return tabController;
//}


@end
