//
//  MainController.m
//  新浪微博
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "HomeController.h"
#import "FriendController.h"
#import "FollowersController.h"
#import "SquareController.h"
#import "MoreController.h"
#import "WBNavigationController.h"
#import "UIBarButtonItem+DS.h"

//#define kDockHeight 36

@interface MainController () <DockDelegate,UINavigationControllerDelegate>

@end

@implementation MainController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    //1.初始化所有的子控制器
    [self addAllChildControllers];
    
    //2.初始化Dock
    [self addDockItems];
    
}

#pragma mark 初始化所有子控制器
- (void)addAllChildControllers
{
    //1 首页
    HomeController *home = [[HomeController alloc]init];
    home.view.backgroundColor = kGlobalBackgroundColor;
    
    WBNavigationController *homeNav = [[WBNavigationController alloc]initWithRootViewController:home];
    homeNav.delegate = self;
    [self addChildViewController:homeNav];
    
    //2 消息
    FollowersController *followers = [[FollowersController alloc]init];
    WBNavigationController *followersNav = [[WBNavigationController alloc]initWithRootViewController:followers];
    followersNav.delegate = self;
    followers.view.backgroundColor = kGlobalBackgroundColor;
    [self addChildViewController:followersNav];
    
    //3 更多
    MoreController *more = [[MoreController alloc]initWithStyle:UITableViewStyleGrouped];
    WBNavigationController *moreNav = [[WBNavigationController alloc]initWithRootViewController:more];
    moreNav.delegate = self;
    [self addChildViewController:moreNav];
    
    
    //4 广场
    SquareController *square = [[SquareController alloc]init];
    WBNavigationController *squareNav = [[WBNavigationController alloc]initWithRootViewController:square];
    squareNav.delegate = self;
    square.view.backgroundColor = kGlobalBackgroundColor;
    [self addChildViewController:squareNav];
    
    
    //5 朋友
    FriendController *friend = [[FriendController alloc]init];
    WBNavigationController *meNav = [[WBNavigationController alloc]initWithRootViewController:friend];
    meNav.delegate = self;
    friend.view.backgroundColor = kGlobalBackgroundColor;
    [self addChildViewController:meNav];

}

#pragma mark 实现导航控制器的代理方法
//导航控制器即将显示新的控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //MyLog(@"即将显示:%@ 的y值是: %f",viewController,viewController.view.frame.origin.y);
    //如果显示的不是根控制器,就需要拉长导航控制器view的高度
    
    //1.获得当前导航控制器的根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) {//不是根控制器
        //2.拉长导航控制器的view
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height + 20;
        navigationController.view.frame = frame;
        //3.添加Dock到根控制器的view上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        
        //调整dock的y值
        dockFrame.origin.y = root.view.frame.size.height - _dock.frame.size.height;
        //MyLog(@"The root controller is:%@",root);
        
        if ([root.view isKindOfClass:[UIScrollView class]]) {//说明根控制器的view是能滚动
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
            //MyLog(@"The scrollView's y is:%f",scroll.frame.origin.y);
        }
        
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
        //4. 添加左上角的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back@2x.png" hightlightedIcon:@"navigationbar_back_highlighted@2x.png" target:self action:@selector(back)];
    }
}

- (void)back
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        //1.让导航控制的view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height - 20;
        navigationController.view.frame = frame;
        
        //2.添加Dock到mainView上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
    }
}

#pragma mark 添加Dock
- (void)addDockItems
{
    //1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x.png"]];
    
    //2.往Dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_home@2x.png" selectedIcon:@"tabbar_home_selected@2x.png" title:@"Home"];
    [_dock addItemWithIcon:@"tabbar_message_center@2x.png" selectedIcon:@"tabbar_message_center_selected@2x.png" title:@"Followers"];
    [_dock addItemWithIcon:@"tabbar_more@2x.png" selectedIcon:@"tabbar_more_selected@2x.png" title:@"More"];
    [_dock addItemWithIcon:@"tabbar_discover@2x.png" selectedIcon:@"tabbar_discover_selected@2x.png" title:@"Discover"];
    [_dock addItemWithIcon:@"tabbar_profile@2x.png" selectedIcon:@"tabbar_profile_selected@2x.png" title:@"Friends"];

}

@end
