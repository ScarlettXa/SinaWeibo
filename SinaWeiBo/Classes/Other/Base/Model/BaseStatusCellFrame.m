//
//  BaseStatusCellFrame.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/2/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "ImageListView.h"
#import "Common.h"

@implementation BaseStatusCellFrame
-(void)setStatus:(Status *)status
{
    _status = status;
    //利用微博数据，计算所有子控件的frame
    
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
    //CGSize screenNameSize = [status.user.screenName sizeWithFont:kScreenNameFont];
    CGSize screenNameSize = [status.user.screenName sizeWithAttributes: @{NSFontAttributeName: kScreenNameFont}];
    _screenNameFrame = (CGRect){{screenNameX,screenNameY},screenNameSize};
    
    //会员图标
    if (status.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    //3.时间
    CGFloat timeX = screenNameX;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    //CGSize timeSize = [status.createdAt sizeWithFont:kTimeFont];
    CGSize timeSize = [status.createdAt sizeWithAttributes:@{NSFontAttributeName: kTimeFont}];
    _timeFrame = (CGRect){{timeX,timeY},timeSize};
    
    //4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName: kSourceFont}];
    _sourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //5.内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellBorderWidth;
    //CGSize textSize = [status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth - 2 * kCellBorderWidth, MAXFLOAT)];
    CGSize textSize = [status.retweetedStatus.text boundingRectWithSize:CGSizeMake(cellWidth - 2 * kCellBorderWidth, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: kTextFont} context:nil].size;
    _textFrame = (CGRect){{textX,textY},textSize};
    
    //6.配图或者有转发微博
    if (status.picUrls.count) {//配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGSize imageSize = [ImageListView imageListSizeWithCount:status.picUrls.count];
        _imageFrame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    }else if(status.retweetedStatus){//7.有转发的微博
        //被转发微博的整体
        CGFloat retweetX = textX;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorderWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        //8.被转发微博的昵称
        CGFloat retweetedScreenNameX = kCellBorderWidth;
        CGFloat retweetedScreenNameY = kCellBorderWidth;
        NSString *name = [NSString stringWithFormat:@"@%@",status.retweetedStatus.user.screenName];
        CGSize retweetedScreenNameSize = [name sizeWithAttributes:@{NSFontAttributeName: kRetweetedScreenNameFont}];
        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameX,retweetedScreenNameY},retweetedScreenNameSize};
        
        //9.被转发微博的内容
        CGFloat retweetedTextX = retweetedScreenNameX;
        CGFloat retweetedTextY = CGRectGetMaxY(_retweetedScreenNameFrame) + kCellBorderWidth;
        //CGSize retweetedTextSize = [status.retweetedStatus.text sizeWithFont:kRetweetedTextFont constrainedToSize:CGSizeMake(retweetWidth - 2 * kCellBorderWidth,MAXFLOAT)];
        CGSize retweetedTextSize = [status.retweetedStatus.text boundingRectWithSize:CGSizeMake(retweetWidth - 2 * kCellBorderWidth,MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: kRetweetedTextFont} context:nil].size;
        _retweetedTextFrame = (CGRect){{retweetedTextX,retweetedTextY},retweetedTextSize};
        
        //10.被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderWidth;
            CGSize imageSize = [ImageListView imageListSizeWithCount:status.retweetedStatus.picUrls.count];
            _retweetedImageFrame = CGRectMake(retweetedImageX, retweetedImageY, imageSize.width, imageSize.height);
            
            retweetHeight += CGRectGetMaxY(_retweetedImageFrame);
        }else{
            retweetHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        
        _retweetedFrame = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
        
    }
    
    //11.整个cell的高度
    _cellHeight = kCellBorderWidth + kCellMargin;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    }else if (status.retweetedStatus){
        _cellHeight += CGRectGetMaxY(_retweetedFrame);
    }else{
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
    
    
}
@end
