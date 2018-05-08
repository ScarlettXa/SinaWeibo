//
//  BaseTextCellFrame.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/15/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseText;
@interface BaseTextCellFrame : NSObject
@property (nonatomic,strong)BaseText *baseText;

@property (nonatomic, readonly) CGFloat cellHeight;//Cell的高度

@property (nonatomic,readonly) CGRect iconFrame; //头像的frame

@property (nonatomic,readonly) CGRect screenNameFrame;//昵称
@property (nonatomic,readonly) CGRect mbIconFrame;//会员图标
@property (nonatomic,readonly) CGRect timeFrame;//时间
@property (nonatomic,readonly) CGRect textFrame;//内容

@end
