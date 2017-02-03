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
#import "ProfileViewController.h"
#import "TweetDetailViewController.h"
#import "TwitterClient.h"
#import "CreateViewController.h"

@interface NavigationManager()

@property (nonatomic, assign, readonly) BOOL isLoggedIn;
@property (nonatomic, strong) UINavigationController *mainNavigationController;
@property (nonatomic, strong) UITabBarController *mainTabBarController;

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
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.mainNavigationController.navigationBarHidden = YES;
    return self.mainNavigationController;
}


- (UIViewController *)mainTabViewController {
    UINavigationController *tweetNavigationController = [self tweetListNavigationController:NO];
    UINavigationController *profileNavigationController = [self profileNavigationController];
    UINavigationController *mentionsNavigationController = [self tweetListNavigationController:YES];
    
    // create tab item
    UITabBarItem *tweetListItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"ic_home.png"] tag:0];
    tweetNavigationController.tabBarItem = tweetListItem;
    
    UITabBarItem *mentionListItem = [[UITabBarItem alloc] initWithTitle:@"Mentions" image:[UIImage imageNamed:@"ic_notifications.png"] tag:1];
    mentionsNavigationController.tabBarItem = mentionListItem;
    
    UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"ic_person.png"] tag:2];
    profileNavigationController.tabBarItem = profileItem;

    self.mainTabBarController = [[UITabBarController alloc] init];
    self.mainTabBarController.viewControllers = @[tweetNavigationController, mentionsNavigationController, profileNavigationController];
    return self.mainTabBarController;
}

// Navigation methods

- (void)logout {
    // Remove access token
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    // Remove current user
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"current_user_data"];
    [defaults synchronize];
    
    // Call login controller
    self.mainNavigationController.viewControllers = @[[self loginViewController]];
}

- (void)login {
    // Call main tab view controller
    self.mainNavigationController.viewControllers = @[[self mainTabViewController]];
}

- (void)pushTweetDetailView:(TweetModel *) tweet {
    UINavigationController *navigationViewController = (UINavigationController *)(self.mainTabBarController.selectedViewController);
    TweetDetailViewController *tweetDetailViewController = [self tweetDetailViewController];
    tweetDetailViewController.tweet = tweet;
    [navigationViewController pushViewController:tweetDetailViewController animated:YES];
}

- (void)pushProfileView:(UserModel *) user {
    UINavigationController *navigationViewController = (UINavigationController *)(self.mainTabBarController.selectedViewController);
    ProfileViewController *profileViewController = [self profileViewController];
    profileViewController.user = user;
    [navigationViewController pushViewController:profileViewController animated:YES];
}

- (void)pushCreateTweetView {
    UINavigationController *navigationViewController = (UINavigationController *)(self.mainTabBarController.selectedViewController);
    [navigationViewController pushViewController:[self createTweetViewController] animated:YES];
}

- (void)popCreateTweetView {
    UINavigationController *navigationViewController = (UINavigationController *)(self.mainTabBarController.selectedViewController);
    [navigationViewController popViewControllerAnimated:YES];
}

// Navigation Controllers

- (UINavigationController *)tweetListNavigationController:(BOOL) isMentionsView {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[self tweetViewController:isMentionsView]];
    return navigationController;
}

- (UINavigationController *)profileNavigationController {
    ProfileViewController *profileViewController = [self profileViewController];
    profileViewController.user = UserModel.currentUser;
    profileViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_create.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushCreateTweetView)];
    profileViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    UIImageView *imageView = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"Twitter_Social_Icon_Blue.png"]];
    imageView.frame = CGRectMake(0, 0, 40, 40);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    profileViewController.navigationItem.titleView = imageView;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    return navigationController;
}

// View Controllers

- (LoginViewController *)loginViewController {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return loginViewController;
}

- (TweetListViewController *)tweetViewController:(BOOL) isMentionsView {
    TweetListViewController *tweetViewController = [[TweetListViewController alloc]
                                                    initWithNibName:@"TweetListViewController" bundle:nil];
    if (isMentionsView) {
        tweetViewController.restorationIdentifier = @"mentions";
    } else {
        tweetViewController.restorationIdentifier = @"home";
    }
    tweetViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_create.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushCreateTweetView)];
    tweetViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    UIImageView *imageView = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"Twitter_Social_Icon_Blue.png"]];
    imageView.frame = CGRectMake(0, 0, 40, 40);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    tweetViewController.navigationItem.titleView = imageView;
    return tweetViewController;
}



- (ProfileViewController *)profileViewController {
    ProfileViewController *profileViewController = [[ProfileViewController alloc]
                                                    initWithNibName:@"ProfileViewController" bundle:nil];
        return profileViewController;
}

- (TweetDetailViewController *)tweetDetailViewController {
    TweetDetailViewController *tweetDetailViewController = [[TweetDetailViewController alloc]
                                                    initWithNibName:@"TweetDetailViewController" bundle:nil];
    return tweetDetailViewController;
}

- (CreateViewController *)createTweetViewController {
    CreateViewController *createTweetViewController = [[CreateViewController alloc] initWithNibName:@"CreateViewController" bundle:nil];
    return createTweetViewController;
}

@end
