//
//  LoginViewController.m
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "NavigationManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(UserModel *user, NSError *error) {
        if (user != nil) {
            // Success
            NSLog(@"Welcome use:%@", user.name);
            [user saveCurrentUserData];
            [[NavigationManager sharedInstance] login];
        } else {
            // Error
        }
    }];
}

@end
