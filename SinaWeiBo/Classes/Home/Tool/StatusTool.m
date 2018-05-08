//
//  StatusTool.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/5/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Status.h"
#import "Comment.h"
#import "Status.h"
#import "Common.h"

@implementation StatusTool
+(void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    [HttpTool getWithPath:@"2/statuses/home_timeline.json" params:@{@"count":@20,@"since_id":@(sinceId),@"max_id":@(maxId)} success:^(id JSON) {
        MyLog(@"获得微博是:%@",JSON);
        if (success == nil) return;
        
        NSMutableArray *statuses = [NSMutableArray array];
        NSArray *array = JSON[@"statuses"];
        for (NSDictionary *dict in array){
            MyLog(@"获得微博字典是:%@",dict);
            Status *s = [[Status alloc] initWithDict:dict];
            [statuses addObject:s];
        }
        MyLog(@"获得微博数组是:%@",statuses);
        //回调block
        success(statuses);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"StatusTool error:%@",error);
    }];
}

+ (void)commentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure
{
    [HttpTool getWithPath:@"2/comments/show.json" params:@{@"id":@(statusId),@"since_id":@(sinceId),@"max_id":@(maxId),@"count":@10} success:^(id JSON) {
        
        if (success == nil) return;
        
        //MyLog(@"成功获取微博评论:%@",JSON);
        //Json数组(装着所有的评论)
        NSArray *array = JSON[@"comments"];
        
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            Comment *c = [[Comment alloc] initWithDict:dict];
            [comments addObject:c];
        }
        //回调block
        success(comments, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"StatusTool error:%@",error);
    }];
}

+ (void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure
{
    [HttpTool getWithPath:@"2/statuses/repost_timeline.json" params:@{@"id":@(statusId),@"since_id":@(sinceId),@"max_id":@(maxId),@"count":@20} success:^(id JSON) {
        
        if (success == nil) return;
        
        //MyLog(@"成功获取微博转发:%@",JSON);
        //Json数组(装着所有的评论)
        NSArray *array = JSON[@"reposts"];
        
        NSMutableArray *reposts = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            Status *r = [[Status alloc] initWithDict:dict];
            [reposts addObject:r];
        }
        //回调block
        success(reposts, [JSON[@"total_number"] intValue], [JSON[@"next_cursor"] longLongValue]);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"StatusTool error:%@",error);
    }];
}

+ (void)statusWithId:(long long)ID success:(SingleStatusSuccessBlock)success failure:(SingleStatusFailureBlock)failure
{
    [HttpTool getWithPath:@"2/statuses/show.json" params:@{@"id": @(ID),} success:^(id JSON) {
        if (success == nil) return;
        Status *s = [[Status alloc] initWithDict:JSON];
        success(s);                     
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"获取单条微博(%lld)失败，原是:%@",ID,error);
    }];
}

+(void)commentStatusWithId:(long long)ID andComment:(NSString *) comment success:(CommentStatusSuccessBlock)success failure:(CommentStatusFailureBlock)failure
{
    [HttpTool postWithPath:@"2/comments/create.json" params:@{@"id": @(ID),@"comment":comment} success:^(id JSON) {
        if (success == nil) return;
        Status *s = [[Status alloc] initWithDict:JSON];
        success(s);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        failure(error);
        MyLog(@"获取单条微博(%lld)失败，原是:%@",ID,error);
    }];
}
@end

