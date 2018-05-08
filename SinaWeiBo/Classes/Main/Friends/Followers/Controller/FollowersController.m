//
//  MessageController.m
//  SinaWeiBo
//
//  Created by TecsonChan on 1/24/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "FollowersController.h"
#import "GroupCell.h"
#import "FriendshipTool.h"
#import "AccountTool.h"
#import "User.h"
#import "HttpTool.h"
#import "MJRefresh.h"

@interface FollowersController() <MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;
    long long _cursor;
}
@end

@implementation FollowersController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置标题
    self.title = @"Fans";
    
    //2.背景颜色
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    //3.设置右上角按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发私信" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self loadNewFollowers];
    
    //添加上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    _footer = footer;
}

#pragma mark - 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        //上拉加载更多
        [self loadMoreFollowers];
    }
}

#pragma mark 加载新的朋友数据
- (void)loadNewFollowers
{
    _data = [NSMutableArray array];
    long long ID = [[AccountTool sharedAccountTool].account.uid longLongValue];
    [FriendshipTool followersWithId:ID cursor:0 success:^(NSArray *followers, int totalNumber, long long nextCursor){
        [_data addObjectsFromArray:followers];
        [self.tableView reloadData];
        _cursor = nextCursor;
        //MyLog(@"目前已加载的粉丝数量是:%ld",_data.count);
    } failure:^(NSError *error) {
        MyLog(@"加载粉丝数据失败，原因是:%@",error);
    }];
}

#pragma mark 加载更多朋友数据
- (void)loadMoreFollowers
{
    long long ID = [[AccountTool sharedAccountTool].account.uid longLongValue];
    [FriendshipTool followersWithId:ID cursor:_cursor success:^(NSArray *followers, int totalNumber, long long nextCursor){
        [_data addObjectsFromArray:followers];
        [self.tableView reloadData];
        _cursor = nextCursor;
        [_footer endRefreshing];
        //MyLog(@"目前已加载的粉丝数量是:%ld",_data.count);
    } failure:^(NSError *error) {
        MyLog(@"加载粉丝数据失败，原因是:%@",error);
    }];
}

@end
