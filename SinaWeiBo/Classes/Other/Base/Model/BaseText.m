//
//  BaseText.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/14/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseText.h"
#import "User.h"

@implementation BaseText

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.text = dict[@"text"];
        self.user = [[User alloc]initWithDict:dict[@"user"]];
        self.source = dict[@"source"];
        
    }
    return self;
}


- (void)setSource:(NSString *)source
{
    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    //MyLog(@"来源字符串:%@",source);
    if (source != nil && [source containsString:@">"] && [source containsString:@"</"]) {
        NSUInteger begin = [source rangeOfString:@">"].location + 1;
        NSUInteger end = [source rangeOfString:@"</"].location;
        _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:NSMakeRange(begin, end - begin)]];
    }
    
}

@end
