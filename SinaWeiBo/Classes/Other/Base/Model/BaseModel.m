//
//  BaseModel.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = [dict[@"id"] longLongValue];
        self.createdAt = dict[@"created_at"];
    }
    return self;
}

- (NSString *)createdAt
{
    //Wed May 11 20:43:10 +0800 2016
    //MyLog(@"createAt is: %@",_createdAt);
    //1.将新浪时间字符串转为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdAt];
    
    //2.将NSDate跟当前时间比较，生成合理的字符串
    NSDate *now = [NSDate date];
    
    //3.获得当前时间和微博发送时间间隔(差多少秒)
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    //4.根据时间间隔算出合理的字符串
    if (delta < 60) {//1分钟内
        return @"1分钟";
    }else if (delta < 60 * 60){//1小时内
        return [NSString stringWithFormat:@"%.f分钟前",delta/60];
    }else if (delta < 60 * 60 * 24){//一天内
        return [NSString stringWithFormat:@"%.f小时前",delta/60/60];
    }else{
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
    
}
@end
