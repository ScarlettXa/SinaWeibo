//
//  Status.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/5/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "Status.h"
#import "User.h"

@implementation Status
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        
        self.picUrls = dict[@"pic_urls"];
        self.originalPic = dict[@"original_pic"];
        self.bmiddlePic = dict[@"bmiddle_pic"];
        
        NSDictionary *retweet = dict[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweet];
        }
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];

    }
    return self;
}

@end
