//
//  BaseTextCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/14/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseTextCell.h"
#import "IconView.h"
#import "BaseText.h"
#import "User.h"
#import "BaseTextCellFrame.h"
#import "UIImage+MJ.h"

@interface BaseTextCell()

@end

@implementation BaseTextCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        //添加所有可能显示的子控件
//    }
//    return self;
//}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    //1.获得文件名
    NSUInteger count = [_myTableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = @"statusdetail_comment_background_middle@2x.png";
    NSString *selectedBgName = @"statusdetail_comment_background_middle_highlighted@2x.png";
    
    if (count - 1 == indexPath.row) {//最后一行
        bgName = @"statusdetail_comment_background_bottom@2x.png";
        selectedBgName = @"statusdetail_comment_background_bottom_highlighted@2x.png";
    }
    
    //2.设置背景图片
    _bg.image = [UIImage resizedImage:bgName];
    _selectedBg.image = [UIImage resizedImage:selectedBgName];
}

- (void)setCellFrame:(BaseTextCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    BaseText *baseText = cellFrame.baseText;
    
    //1.头像
    _icon.frame = cellFrame.iconFrame;
    _icon.user = baseText.user;
    
    //2.昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = baseText.user.screenName;
    
    //3.判断是不是会员
    if (baseText.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    }else{
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    
    //4.内容
    _text.frame = cellFrame.textFrame;
    _text.text = baseText.text;
    
    //5.时间
    _time.frame = cellFrame.timeFrame;
    _time.text = baseText.createdAt;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.x = kTableBorderWidth;
//    frame.origin.y += kTableBorderWidth;
//    frame.size.width -= kTableBorderWidth * 2;
//    frame.size.height -= kCellMargin;
//    
//    [super setFrame:frame];
//}

@end
