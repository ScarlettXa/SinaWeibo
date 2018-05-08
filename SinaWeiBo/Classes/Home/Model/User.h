//
//  User.h
//  SinaWeiBo
//
//  Created by TecsonChan on 4/5/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseModel.h"

typedef enum {
    kVerifiedTypeNone = - 1, // 没有认证
    kVerifiedTypePersonal = 0, // 个人认证
    kVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    kVerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    kVerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    kVerifiedTypeDaren = 220 // 微博达人
} VerifiedType;

typedef enum {
    kMBTypeNone = 0, // 没有
    kMBTypeNormal, // 普通
    kMBTypeYear // 年费
} MBType;

@interface User : BaseModel
@property (nonatomic,copy) NSString *screenName;
@property (nonatomic,copy) NSString *profileImageUrl;
@property (nonatomic,assign) BOOL verified; //是否是微博认证用户，即加V用户
@property (nonatomic,assign) VerifiedType verifiedType;//认证类型 0 ~ 100
@property (nonatomic,assign) int mbrank;//会员等级
@property (nonatomic,assign) MBType mbtype;//会员类型


- (id)initWithDict:(NSDictionary *)dict;
@end
