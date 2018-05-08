 //
//  Status.h
//  SinaWeiBo
//
//  Created by TecsonChan on 4/5/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseText.h"
@interface Status : BaseText
@property (nonatomic,strong) NSArray *picUrls;//微博配图
@property (nonatomic,strong) NSString *originalPic;//微博原始配图
@property (nonatomic,strong) NSString *bmiddlePic;//中等微博配图
@property (nonatomic,strong) Status *retweetedStatus;
@property (nonatomic,assign) int repostsCount;//微博转发数
@property (nonatomic,assign) int commentsCount;//微博评论数
@property (nonatomic,assign) int attitudesCount;//微博表态数

@end
