//
//  User.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/5/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        
        //MyLog(@"User dictionary:%@",dict);
        
        self.screenName = dict[@"screen_name"];
        self.profileImageUrl = dict[@"profile_image_url"];
        
        self.verified = [dict[@"verified"] boolValue];
        self.verifiedType = [dict[@"verified_type"] intValue];
        self.mbrank = [dict[@"mbrank"] intValue];
        self.mbtype = [dict[@"mbtype"] intValue];
    }
    return self;
}
@end
