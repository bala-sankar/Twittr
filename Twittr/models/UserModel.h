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

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
