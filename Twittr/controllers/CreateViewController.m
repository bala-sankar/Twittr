//
//  CreateViewController.m
//  Twittr
//
//  Created by Balachandar Sankar on 2/1/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import "CreateViewController.h"
#import "NavigationManager.h"
#import "TwitterClient.h"

@interface CreateViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetContentTextView;

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetContentTextView.text = @"What's happening?";
    self.tweetContentTextView.textColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(sendTweet)];
    self.tweetContentTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"What's happening?"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)sendTweet {
    NSString *URLString = @"1.1/statuses/update.json";
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:self.tweetContentTextView.text forKey:@"status"];
    [[TwitterClient sharedInstance] POST:URLString
                              parameters: params
                                progress:^(NSProgress * _Nonnull uploadProgress) {
                                    NSLog(@"Sending tweets...");
                                }
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"Successfully tweet sent");
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     NSLog(@"Failed to send tweet.");
                                 }];
    [self popView];
}

- (void)popView {
    [[NavigationManager sharedInstance] popCreateTweetView];
}
@end
