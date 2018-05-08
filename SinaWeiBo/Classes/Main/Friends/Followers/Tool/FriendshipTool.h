//
//  FriendshipTool.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

typedef void (^FollowersSuccessBlock)(NSArray *followers, int totalNumber, long long nextCursor);
typedef void (^FollowersFailureBlock)(NSError *error);

typedef void (^FriendsSuccessBlock)(NSArray *friends, int totalNumber, long long nextCursor);
typedef void (^FriendsFailureBlock)(NSError *error);
#import <Foundation/Foundation.h>

@interface FriendshipTool : NSObject
+ (void)followersWithId:(long long )ID cursor:(long long)cursor success:(FollowersSuccessBlock)success failure:(FollowersFailureBlock)failure;
+ (void)friendsWithId:(long long )ID cursor:(long long)cursor success:(FriendsSuccessBlock)success failure:(FriendsFailureBlock)failure;
@end
