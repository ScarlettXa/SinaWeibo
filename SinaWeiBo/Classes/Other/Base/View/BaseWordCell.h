//
//  BaseWordCell.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseCell.h"
@class IconView;
@interface BaseWordCell : BaseCell
{
    IconView *_icon; //头像
    UILabel *_screenName;//昵称
    UIImageView *_mbIcon;//会员图标
    
    UILabel *_time;//时间
    UILabel *_source;//来源
    UILabel *_text;//内容

}
@end
