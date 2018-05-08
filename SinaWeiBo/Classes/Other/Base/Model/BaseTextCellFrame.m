//
//  BaseTextCellFrame.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/15/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseTextCellFrame.h"
#import "IconView.h"
#import "User.h"
#import "BaseText.h"
#import "Common.h"

@implementation BaseTextCellFrame
- (void)setBaseText:(BaseText *)baseText
{
    _baseText = baseText;
    
    //整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - kTableBorderWidth * 2;
    
    //1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = [IconView iconSizeWithType:kIconTypeSmall];
    _iconFrame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    //2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [baseText.user.screenName sizeWithAttributes: @{NSFontAttributeName: kScreenNameFont}];
    _screenNameFrame = (CGRect){{screenNameX,screenNameY},screenNameSize};
    
    //会员图标
    if (baseText.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }

    //3.微博评论内容
    CGFloat textX = screenNameX;
    CGFloat textY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGFloat textWidth = cellWidth - kCellBorderWidth - textX;
    //CGSize textSize = [baseText.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(textWidth, MAXFLOAT)];
    CGSize textSize = [baseText.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: kTextFont} context:nil].size;
    _textFrame = (CGRect){{textX,textY},textSize};
    
    
    //4.时间
    CGFloat timeX = textX;
    CGFloat timeY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
    CGSize timeSize = CGSizeMake(textWidth, kTimeFont.lineHeight);
    _timeFrame = (CGRect){{timeX,timeY},timeSize};
    
    //5.cell的高度
    _cellHeight = CGRectGetMaxY(_timeFrame) + kCellBorderWidth;
    
}
@end
