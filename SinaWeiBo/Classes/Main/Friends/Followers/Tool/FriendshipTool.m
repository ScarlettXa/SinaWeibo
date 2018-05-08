//
//  FriendshipTool.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "FriendshipTool.h"
#import "HttpTool.h"
#import "User.h"

@implementation FriendshipTool
+ (void)followersWithId:(long long)ID cursor:(long long)cursor success:(FollowersSuccessBlock)success failure:(FollowersFailureBlock)failure
{
    [HttpTool getWithPath:@"2/friendships/followers.json" params:@{@"uid":@(ID),@"cursor":@(cursor)} success:^(id JSON) {
        
        if (success == nil) return;
        
        //MyLog(@"成功获取粉丝数据:%@",JSON);
        //Json数组(装着所有的评论)
        NSArray *array = JSON[@"users"];
        NSMutableArray *followers = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            User *u = [[User alloc] initWithDict:dict];
            [followers addObject:u];
        }
        //回调block
        success(followers,[JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"FriendshipTool error:%@",error);
    }];
}

+ (void)friendsWithId:(long long)ID cursor:(long long)cursor success:(FollowersSuccessBlock)success failure:(FollowersFailureBlock)failure
{
    [HttpTool getWithPath:@"2/friendships/friends.json" params:@{@"uid":@(ID),@"cursor":@(cursor)} success:^(id JSON) {
        
        if (success == nil) return;
        
        //MyLog(@"成功获取朋友数据:%@",JSON);
        //Json数组(装着所有的评论)
        NSArray *array = JSON[@"users"];
        NSMutableArray *followers = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            User *u = [[User alloc] initWithDict:dict];
            [followers addObject:u];
        }
        //回调block
        success(followers,[JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"FriendshipTool error:%@",error);
    }];
}
@end
