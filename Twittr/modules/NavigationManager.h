//
//  NavigationManager.h
//  Twittr
//
//  Created by Balachandar Sankar on 2/1/17.
//  Copyright © 2017 Balachandar Sankar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationManager : NSObject

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (instancetype)sharedInstance;

@end
