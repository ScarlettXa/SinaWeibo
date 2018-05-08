//
//  BaseStatusCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/2/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseStatusCell.h"
#import "IconView.h"
#import "ImageListView.h"
#import "UIImage+MJ.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"

@interface BaseStatusCell()
{
    
    ImageListView *_image;//配图
    
    UILabel *_retweetedSceenName; //被转发微博作者的昵称
    UILabel *_retweetedText;//被转发微博的内容
    ImageListView *_retweetedImage;//被转发微博的配图
}
@end

@implementation BaseStatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加微博本身的子控件
        [self addAllSubviews];
        
        //2.添加被转发微博的子控件
        [self addRetweetedAllSubviews];
        
        //3.设置背景
        [self setBackground];
    }
    return self;
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

#pragma mark 添加微博本身的子控件
- (void)addAllSubviews
{
    
    //1.配图
    _image = [[ImageListView alloc]init];
    [self.contentView addSubview:_image];
    
}

#pragma mark 添加被转发微博的子控件
- (void)addRetweetedAllSubviews
{
    //1.被转发微博的父控件
    _retweeted = [[UIImageView alloc]init];
    _retweeted.image = [UIImage resizedImage:@"timeline_retweet_background@2x.png"];
    _retweeted.userInteractionEnabled = YES;
    [self.contentView addSubview:_retweeted];
    
    //2.被转发微博的昵称
    _retweetedSceenName = [[UILabel alloc]init];
    _retweetedSceenName.font = kRetweetedScreenNameFont;
    _retweetedSceenName.textColor = kRetweetedScreenNameColor;
    _retweetedSceenName.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedSceenName];
    
    //3.被转发微博的内容
    _retweetedText = [[UILabel alloc]init];
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.numberOfLines = 0;
    _retweetedText.backgroundColor = [UIColor clearColor];
    [_retweeted addSubview:_retweetedText];
    
    //4.被转发微博的配图
    _retweetedImage = [[ImageListView alloc]init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setBackground
{
    //1.默认背景
    _bg.image = [UIImage resizedImage:@"common_card_background@2x.png"];
    
    //2.长按背景
    _selectedBg.image = [UIImage resizedImage:@"common_card_background_highlighted@2x.png"];
    
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    Status *s = cellFrame.status;
    
    //1.头像
    _icon.frame = cellFrame.iconFrame;
    [_icon setUser:s.user type:kIconTypeSmall];
    
    //2.昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = s.user.screenName;
    
    //判断是不是会员
    if (s.user.mbtype == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    }else{
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    
    //3.时间
    CGFloat timeX = cellFrame.screenNameFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(cellFrame.screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [s.createdAt sizeWithFont:kTimeFont];
    _time.frame = (CGRect){{timeX,timeY},timeSize};
    _time.text = s.createdAt;
    
    //4.来源
    CGFloat sourceX = CGRectGetMaxX(_time.frame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [s.source sizeWithFont:kSourceFont];
    _source.frame = (CGRect){{sourceX,sourceY},sourceSize};
    _source.text = s.source;
    
    //5.内容
    _text.frame = cellFrame.textFrame;
    _text.text = s.text;
    
    //6.配图
    if (s.picUrls.count) {
        _image.hidden = NO;
        _image.frame = cellFrame.imageFrame;
        MyLog(@"原始图:%@",s.originalPic);
        MyLog(@"中等图:%@",s.bmiddlePic);
        _image.originalPic = s.originalPic;
        _image.bmiddlePic = s.bmiddlePic;
        _image.imageUrls = s.picUrls;
                //        NSString *imageStr = s.picUrls[0][@"thumbnail_pic"];
        //        NSURL *imageURL = [NSURL URLWithString:imageStr];
        //        [_image setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Icon.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    }else{
        _image.hidden = YES;
    }
    
    //7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.hidden = NO;
        _retweeted.frame = cellFrame.retweetedFrame;
        
        //8.昵称
        _retweetedSceenName.frame = cellFrame.retweetedScreenNameFrame;
        _retweetedSceenName.text = [NSString stringWithFormat:@"@%@",s.retweetedStatus.user.screenName];
        
        //9.内容
        _retweetedText.frame = cellFrame.retweetedTextFrame;
        _retweetedText.text = s.retweetedStatus.text;
        
        //10.配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            _retweetedImage.frame = cellFrame.retweetedImageFrame;
            _retweetedImage.originalPic = s.retweetedStatus.originalPic;
            _retweetedImage.bmiddlePic = s.retweetedStatus.bmiddlePic;
            _retweetedImage.imageUrls = s.retweetedStatus.picUrls;
            
        }else{
            _retweetedImage.hidden = YES;
        }
    }else{
        _retweeted.hidden = YES;
    }
}

@end
