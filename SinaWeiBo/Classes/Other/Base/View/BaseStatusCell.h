//
//  BaseStatusCell.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/2/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseWordCell.h"

@class BaseStatusCellFrame;
@interface BaseStatusCell : BaseWordCell
{
    UIImageView *_retweeted;//被转发微博的父控件
}
@property (nonatomic,strong) BaseStatusCellFrame *cellFrame;
@end
