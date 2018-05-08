//
//  HomeController.m
//  SinaWeiBo
//
//  Created by TecsonChan on 1/19/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+DS.h"
#import "AccountTool.h"
#import "StatusTool.h"
#import "Status.h"
#import "User.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "MJRefresh.h"
#import "StatusDetailController.h"
#import "UIImage+MJ.h"

#import "Common.h"

@interface HomeController () <MJRefreshBaseViewDelegate>
{
    NSMutableArray *_statusFrames;
}
@end

@implementation HomeController
#pragma mark 重写这个方法的目的是:去掉父类默认的操作:显示滚动条.
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置界面的属性
    [self buidUI];
    
    //2.获得用户的微博数据
    //[self loadStatusData];
    
    
    //2.集成刷新控件
    [self addRefreshViews];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableBorderWidth, 0);
    
    
    //苹果自带刷新方法
//    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//    [self.tableView addSubview:refresh];
//    [refresh addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark 集成刷新控件
- (void)addRefreshViews
{
    _statusFrames = [NSMutableArray array];

    //1.下拉刷新
    MJRefreshHeaderView  *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
    MyLog(@"下拉刷新的y is:%@",self.tableView);
    
    //2.上拉加载更多
    MJRefreshFooterView  *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    
}

#pragma mark 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        //上拉加载更多
        [self loadMoreStatusData:refreshView];
    }else{
        //下拉刷新
        [self loadNewStatusData:refreshView];
    }
    
}

#pragma mark 加载新的微博数据
- (void)loadNewStatusData:(MJRefreshBaseView *)refreshView
{
    MyLog(@"进入下拉状态");
    //1.第1条微博
    StatusCellFrame *f = _statusFrames.count?_statusFrames[0]:nil;
    //MyLog(@"The first status's frame is:%@",f);
    long long first = [f.status ID];
    //MyLog(@"The first status's ID is:%lld",first);
    
    //2.获取微博数据
    [StatusTool statusesWithSinceId:first maxId:0 success:^(NSArray *statuses) {
        //MyLog(@"微博数据:%@",statuses);
        //在拿到最新的微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            //MyLog(@"The %lld status's frame is:%@",s.ID,f);
            [newFrames addObject:f];
        }
        //MyLog(@"The new status's size is:%lu",(unsigned long)newFrames.count);
        
        //2.将newFrames整体插入到旧数据的前面
        [_statusFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        //call reloadData之后就会调用cell的数据源方法和代理方法
        //3.刷新表格
        [self.tableView reloadData];
        
        //4.让刷新控件停止刷新状态
        [refreshView endRefreshing];
        
        //5.顶部展示最新微博的数目
        [self showNewStatusCount:statuses.count];
        
    } failure:^(NSError *error) {
        MyLog(@"错误数据原因:%@",error);
        [refreshView endRefreshing];
    }];
    
}

#pragma mark 展示最新微博的数目
- (void)showNewStatusCount:(NSUInteger)count
{
    //1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;
    btn.adjustsImageWhenDisabled = NO;//不调节图片的透明度
    [btn setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background@2x.png"] forState:UIControlStateNormal];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 30;
    btn.frame = CGRectMake(0,h, w, h);
    
    NSString *title = count?[NSString stringWithFormat:@"共有%lu条微博更新",(unsigned long)count]:@"没有新的微博更新";
    [btn setTitle:title forState:UIControlStateNormal];
    
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    //2.开始执行动画
    CGFloat duration = 0.5;
    [UIView animateWithDuration:duration animations:^{//下来
        btn.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{//上去
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
        
    }];
    
}


#pragma mark 加载更多微博数据
- (void)loadMoreStatusData:(MJRefreshBaseView *)refreshView
{
    MyLog(@"进入上拉状态");
    //1.最后1条微博的ID
    StatusCellFrame *f = _statusFrames.count?[_statusFrames lastObject]:nil;
    long long last = [f.status ID];
    //MyLog(@"The first status's ID is:%lld",last);
    
    //2.获取微博数据
    [StatusTool statusesWithSinceId:0 maxId:last - 1 success:^(NSArray *statuses) {
        //MyLog(@"微博数据:%@",statuses);
        //在拿到最新的微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        //MyLog(@"The new status's size is:%lu",(unsigned long)newFrames.count);
        
        //2.将newFrames整体插入到旧数据的前面
        [_statusFrames addObjectsFromArray:newFrames];
        
        //call reloadData之后就会调用cell的数据源方法和代理方法
        //3.刷新表格
        [self.tableView reloadData];
        
        //4.让刷新控件停止刷新状态
        [refreshView endRefreshing];
        
    } failure:^(NSError *error) {
        MyLog(@"错误数据原因:%@",error);
        [refreshView endRefreshing];
    }];

}

#pragma mark 加载微博数据
- (void)loadStatusData
{
    _statusFrames = [NSMutableArray array];
    
    [StatusTool statusesWithSinceId:0 maxId:0 success:^(NSArray *statuses) {
        //MyLog(@"微博数据:%@",statuses);
        
        for (Status *s in statuses) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [_statusFrames addObject:f];
        }
        
        //[_statuses addObjectsFromArray:statuses];
        //call reloadData之后就会调用cell的数据源方法和代理方法
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MyLog(@"错误数据原因:%@",error);
    }];
    
    CGRect frame = self.view.frame;
    self.view.frame = frame;
    MyLog(@"The y of the HomeController is:%f",frame.origin.y);
}


//苹果自带刷新方法
- (void)startRefresh:(UIRefreshControl *)refresh
{
    // 1.第1条微博的ID
    //1.第1条微博
    StatusCellFrame *f = _statusFrames.count?_statusFrames[0]:nil;
    long long first = [f.status ID];
    //long long first = [[_statusFrames[0] status] ID];
    
    // 2.获取微博数据
    [StatusTool statusesWithSinceId:first maxId:0 success:^(NSArray *statues){
        // 1.在拿到最新微博数据的同时计算它的frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statues) {
            StatusCellFrame *f = [[StatusCellFrame alloc] init];
            f.status = s;
            [newFrames addObject:f];
        }
        
        // 2.将newFrames整体插入到旧数据的前面
        [_statusFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
        
        // 3.刷新表格
        [self.tableView reloadData];
        
        // 4.让刷新控件停止刷新状态
        [refresh endRefreshing];
    } failure:nil];
}


#pragma mark 设置界面的属性
- (void)buidUI
{
    //1.设置标题
    self.title = @"Home";
    
    //2.左边的item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendattention@2x.png" hightlightedIcon:@"navigationbar_friendattention_highlighted@2x.png" target:self action:@selector(sendStatus)];
    
    //3.右边的item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_icon_radar@2x.png" hightlightedIcon:@"navigationbar_icon_radar_highlighted@2x.png" target:self action:@selector(popMenu)];
    
    //4.背景颜色
    self.view.backgroundColor = kGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark -发微博
- (void)sendStatus
{
    MyLog(@"发微博");
}

#pragma mark -弹出菜单
- (void)popMenu
{

    MyLog(@"弹出菜单");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//以下三个方法是在[self.tableView reloadData]调用之后才调用的

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.cellFrame = _statusFrames[indexPath.row];

    //MyLog(@"create cell:%ld and cell's y is:%f",(long)indexPath.row,cell.frame.origin.y);
    return cell;
}


#pragma mark 返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MyLog(@"set height for cell:%ld",(long)indexPath.row);
    return [_statusFrames[indexPath.row] cellHeight];
}

#pragma mark 监听cell的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailController *detail = [[StatusDetailController alloc] init];
    StatusCellFrame *f = _statusFrames[indexPath.row];
    detail.status = f.status;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    //[ super viewWillAppear :animated ] ;
    
//    CGRect rect = self . navigationController . navigationBar . frame ;
//    
//    self . navigationController . navigationBar . frame = CGRectMake ( rect . origin . x , rect . origin . y , rect . size . width , 104 ) ;
}
//
//- ( void ) viewWillAppear : ( BOOL ) animated {
//    
//    [ super viewWillAppear :animated ] ;
//    
//    CGRect rect = self . navigationController . navigationBar . frame ;
//    
//    self . navigationController . navigationBar . frame = CGRectMake ( rect . origin . x , rect . origin . y , rect . size . width , 104 ) ;
//    
//}
//- ( void ) viewWillDisappear : ( BOOL ) animated {
//    
//    [ super viewWillDisappear :animated ] ;
//    
//    CGRect rect = self . navigationController . navigationBar . frame ;
//    
//    self . navigationController . navigationBar . frame = CGRectMake ( rect . origin . x , rect . origin . y , rect . size . width , 44 ) ;
//    
//}

@end
