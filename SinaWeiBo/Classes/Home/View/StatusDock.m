//
//  StatusDock.m
//  SinaWeiBo
//
//  Created by TecsonChan on 5/17/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "StatusDock.h"
#import "UIImage+MJ.h"
#import "NSString+DS.h"
#import "Common.h"
#import "StatusTool.h"

@interface StatusDock()
{
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitude;
}
@end

@implementation StatusDock

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        //0.设置整个dock的背景
        self.image = [UIImage resizedImage:@"timeline_card_bottom@2x.png"];
        
        //1.添加三个按钮
        _repost = [self addBtn:@"转发" icon:@"timeline_icon_retweet@2x.png" bg:@"timeline_card_leftbottom@2x.png" index:0];
        _comment = [self addBtn:@"评论" icon:@"timeline_icon_comment@2x.png" bg:@"timeline_card_middlebottom@2x.png" index:1];
        _attitude = [self addBtn:@"赞" icon:@"timeline_icon_unlike@2x.png" bg:@"timeline_card_rightbottom@2x.png" index:2];
        
        [_comment addTarget:self action:@selector(popUpCommentWindow) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void) popUpCommentWindow
{
    MyLog(@"触发评论.....");
    NSString *comment = @"超赞";
    [StatusTool commentStatusWithId:4058740322398445 andComment:comment success:^(Status *status) {
        MyLog(@"评论成功!");
    } failure:^(NSError *error) {
        MyLog(@"评论失败!");
    }];
    
}

- (UIButton *)addBtn:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(NSUInteger)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //标题
    [btn setTitle:title forState:UIControlStateNormal];
    //图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //普通背景
    [btn setBackgroundImage:[UIImage resizedImage:bg] forState:UIControlStateNormal];
    //高亮背景
    [btn setBackgroundImage:[UIImage resizedImage:[bg fileAppend:@"_highlighted@2x"]] forState:UIControlStateHighlighted];
    
    //设置文字颜色
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    
    //设置文字格式
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //设置frame
    CGFloat w = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * w, 0, w, kStatusDockHeight);
    //调节文字左边的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    
    if (index) {//index != 0
        UIImage *img = [UIImage imageNamed:@"timeline_card_bottom_line@2x.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.center = CGPointMake(btn.frame.origin.x, kStatusDockHeight * 0.5);
        [self addSubview:divider];
    }
    
    return btn;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    frame.size.height = kStatusDockHeight;
    [super setFrame:frame];
}

- (void)setStatus:(Status *)status
{
    _status = status;
        
    //1.转发
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    
    //1.评论
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    
    //1.赞
   [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
    
}

- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) {//上万
        CGFloat finalCount = count / 10000.0;
        NSString *repostsTitle = [NSString stringWithFormat:@"%.1f万",finalCount];
        repostsTitle = [repostsTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:repostsTitle forState:UIControlStateNormal];
    }else if (count > 0){//一万以内
        NSString *repostsTitle = [NSString stringWithFormat:@"%d",count];
        [btn setTitle:repostsTitle forState:UIControlStateNormal];
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }

}

@end
