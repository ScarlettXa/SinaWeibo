//
//  BaseStatusCellFrame.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/2/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"
#import <UIKit/UIKit.h>

@interface BaseStatusCellFrame : NSObject
{
    CGFloat _cellHeight;
    CGRect _retweetedFrame;
}
@property (nonatomic,strong) Status *status;

@property (nonatomic, readonly) CGFloat cellHeight;//Cell的高度

@property (nonatomic,readonly) CGRect iconFrame; //头像的frame

@property (nonatomic,readonly) CGRect screenNameFrame;//昵称
@property (nonatomic,readonly) CGRect mbIconFrame;//会员图标
@property (nonatomic,readonly) CGRect timeFrame;//时间
@property (nonatomic,readonly) CGRect sourceFrame;//来源
@property (nonatomic,readonly) CGRect textFrame;//内容
@property (nonatomic,readonly) CGRect imageFrame;//配图

@property (nonatomic,readonly) CGRect retweetedFrame;//被转发微博的父控件
@property (nonatomic,readonly) CGRect retweetedScreenNameFrame; //被转发微博作者的昵称
@property (nonatomic,readonly) CGRect retweetedTextFrame;//被转发微博的内容
@property (nonatomic,readonly) CGRect retweetedImageFrame;//被转发微博的配图
@end
