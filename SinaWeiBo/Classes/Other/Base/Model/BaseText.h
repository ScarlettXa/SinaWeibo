//
//  BaseText.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/14/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseModel.h"
@class User;
@interface BaseText : BaseModel
@property (nonatomic, copy) NSString *text;//评论内容
@property (nonatomic, strong) User *user;//评论者
@property (nonatomic,copy) NSString *source;//评论来源
@end
