//
//  TwitterClient.h
//  Twittr
//
//  Created by Balachandar Sankar on 1/31/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "UserModel.h"

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *)getInstance;

- (void)loginWithCompletion:(void (^)(UserModel *user, NSError *error))completion;
- (void)openUrl:(NSURL *)url;

@end
