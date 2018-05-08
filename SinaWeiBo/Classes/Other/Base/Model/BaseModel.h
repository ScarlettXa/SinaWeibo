//
//  BaseModel.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic,assign) long long ID;
@property (nonatomic, copy) NSString *createdAt;//评论时间
- (id)initWithDict:(NSDictionary *)dict;
@end
