//
//  Account.m
//  SinaWeiBo
//
//  Created by TecsonChan on 4/4/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "Account.h"

@implementation Account
#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
