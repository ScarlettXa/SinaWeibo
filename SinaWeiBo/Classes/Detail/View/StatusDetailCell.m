//
//  StatusDetailCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 6/2/16.
//  Copyright © 2016 itcast. All rights reserved.
// 微博详情中的Cell

#import "StatusDetailCell.h"
#import "RetweetedDock.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "StatusDetailController.h"
#import "RootTabBarController.h"

@interface StatusDetailCell()
{
    RetweetedDock *_dock;
}
@end

@implementation StatusDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //1.操作条
        RetweetedDock *dock = [[RetweetedDock alloc] init];
        dock.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        CGFloat x = _retweeted.frame.size.width - dock.frame.size.width;
        CGFloat y = _retweeted.frame.size.height - dock.frame.size.height;
        dock.frame = CGRectMake(x, y, 0, 0);
        _dock = dock;
        [_retweeted addSubview:dock];
        
        //2.监听被转发微博的点击
        [_retweeted addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
    }
    return self;
}

- (void)showRetweeted
{
    //展示被转发的微博
    StatusDetailController *detail = [[StatusDetailController alloc] init];
    
    detail.status = _dock.status;
    
    RootTabBarController *rootTab = (RootTabBarController *)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootTab.selectedViewController;
    [nav pushViewController:detail animated:YES];
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    //设置子控件的数据
    _dock.status = cellFrame.status.retweetedStatus;
    
}

@end
