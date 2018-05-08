//
//  StatusTool.h
//  SinaWeiBo
//
//  Created by TecsonChan on 4/5/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;
//statuses装的都是Status对象
typedef void (^StatusSuccessBlock)(NSArray *statuses);
typedef void (^StatusFailureBlock)(NSError *error);

typedef void (^CommentsSuccessBlock)(NSArray *comments, int totalNumber, long long nextCursor);
typedef void (^CommentsFailureBlock)(NSError *error);

typedef void (^RepostsSuccessBlock)(NSArray *reposts, int totalNumber, long long nextCursor);
typedef void (^RepostsFailureBlock)(NSError *error);

typedef void (^SingleStatusSuccessBlock)(Status *status);
typedef void (^SingleStatusFailureBlock)(NSError *error);

typedef void (^CommentStatusSuccessBlock)(Status *status);
typedef void (^CommentStatusFailureBlock)(NSError *error);

@interface StatusTool : NSObject
//抓取微博数据
+ (void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;
//抓取某条微博的评论数据
+ (void)commentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure;

//抓取某条微博的转发数据
+ (void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure;

// 抓取单条微博数据
+ (void)statusWithId:(long long)ID  success:(SingleStatusSuccessBlock)success failure:(SingleStatusFailureBlock)failure;

//评论单条微博
+ (void)commentStatusWithId:(long long)ID andComment:(NSString *) comment success:(CommentStatusSuccessBlock)success failure:(CommentStatusFailureBlock)failure;

@end
