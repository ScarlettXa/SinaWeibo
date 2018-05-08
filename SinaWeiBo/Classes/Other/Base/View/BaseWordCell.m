//
//  BaseWordCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/18/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "BaseWordCell.h"
#import "IconView.h"

@implementation BaseWordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加所有可能显示的子控件
        [self addMySubViews];
    }
    return self;
}

- (void)addMySubViews
{
    //1.头像
    _icon = [[IconView alloc]init];
    _icon.type = kIconTypeSmall;
    [self.contentView addSubview:_icon];
    
    //2.昵称
    _screenName = [[UILabel alloc]init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    //皇冠图标
    _mbIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_membership@2x.png"]];
    [self addSubview:_mbIcon];
    
    //3.时间
    _time = [[UILabel alloc]init];
    _time.font = kTimeFont;
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    //4.来源
    _source = [[UILabel alloc]init];
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    //5.内容
    _text = [[UILabel alloc]init];
    _text.font = kTextFont;
    _text.numberOfLines = 0;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
}

@end
