//
//  DetailHeader.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/6/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "DetailHeader.h"
//#import "UIImage+MJ.h"
#import "Common.h"

@interface DetailHeader()
{
    UIButton *_selectedBtn;
}
@end

@implementation DetailHeader

+ (id)header
{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailHeader" owner:nil options:nil][0];
}

#pragma mark 监听按钮点击
- (IBAction)btnClick:(UIButton *)sender
{
    MyLog(@"btnClick");
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    //MyLog(@"当前选中的按钮是:%@",sender);
    //移动三角形指示器
//    [UIView animateWithDuration:0.3 animations:^{
//        //MyLog(@"移动三角指示器");
//        CGPoint center = _hint.center;
//        center.x = sender.center.x;
//        _hint.center = center;
//        //MyLog(@"设置三角的中点:%f",_hint.center.x);
//    }];
//    
    
    DetailHeaderBtnType type = (sender==_repost)?kDetailHeaderBtnTypeRepost:((sender==_comment)?kDetailHeaderBtnTypeComment:kDetailHeaderBtnTypeLike);
    
    _currentBtnType = type;
    
    //通知代理
    if ([_delegate respondsToSelector:@selector(detailHeader:btnClick:)]) {
        //MyLog(@"最终三角的中点是:%f",_hint.center.x);
        [_delegate detailHeader:self btnClick:type];
    }
    
}

- (void)awakeFromNib
{
    MyLog(@"awakeFromNib");
    //self.backgroundColor = kGlobalBackgroundColor;
    [self btnClick:_comment];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

//- (void)drawRect:(CGRect)rect
//{
//    UIImage *image = [UIImage resizedImage:@"statusdetail_comment_top_background@2x.png"];
//    [image drawInRect:rect];
//}

-(void)setStatus:(Status *)status
{
    _status = status;
    
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
}

- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) {//上万
        CGFloat finalCount = count / 10000.0;
        NSString *repostsTitle = [NSString stringWithFormat:@"%.1f万 %@",finalCount,title];
        repostsTitle = [repostsTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:repostsTitle forState:UIControlStateNormal];
    }else if (count >= 0){//一万以内
        NSString *repostsTitle = [NSString stringWithFormat:@"%d %@",count,title];
        [btn setTitle:repostsTitle forState:UIControlStateNormal];
    }
    
}

@end
