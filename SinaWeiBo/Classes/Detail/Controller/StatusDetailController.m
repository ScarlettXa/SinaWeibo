//
//  StatusDetailController.m
//  SinaWeiBo
//
//  Created by TecsonChan on 5/28/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "StatusDetailController.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "DetailHeader.h"
#import "StatusTool.h"
#import "Status.h"
#import "CommentCellFrame.h"
#import "RepostCellFrame.h"
#import "Comment.h"
#import "RepostCell.h"
#import "CommentCell.h"
#import "MJRefresh.h"
#import "StatusCellFrame.h"

@interface StatusDetailController () <DetailHeaderDelegate,MJRefreshBaseViewDelegate,UIGestureRecognizerDelegate>
{
    StatusDetailCellFrame *_detailFrame;
    NSMutableArray *_repostFrames;//转发数frame数据
    NSMutableArray *_commentFrames;//评论数frame数据
    DetailHeader *_detailHeader;
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    BOOL _commentLastPage;//评论数据是否为最后一页
    BOOL _repostLastPage;//转发数据是否是最后一页
}
@end

@implementation StatusDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTableBorderWidth, 0);
    
    _detailFrame = [[StatusDetailCellFrame alloc] init];
    _detailFrame.status = _status;
    
    _repostFrames = [NSMutableArray array];
    _commentFrames = [NSMutableArray array];
    
    _commentLastPage = YES;
    _repostLastPage = YES;
    
    //添加上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    //footer.hidden = YES;
    _footer = footer;
    
    //添加下拉刷新更新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    _header = header;
    
    if(_detailHeader == nil){
        DetailHeader *header = [DetailHeader header];
        header.delegate = self;
        _detailHeader = header;
    }
    
    //默认点击评论
    [self detailHeader:nil btnClick:kDetailHeaderBtnTypeComment];
    
    //支持手势滑动返回上一级界面
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //self.navigationController.interactivePopGestureRecognizer.enabled = YES;

}

#pragma mark 获得当前需要使用的数组
- (NSMutableArray *)currentFrames
{
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        return _commentFrames;
    }else {
        return _repostFrames;
    }
}

#pragma mark - 数据源方法\代理方法
#pragma mark 1.有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //MyLog(@"numberOfSectionsInTableView 有多少组");
    //判断上拉加载更多的控件要不要显示
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment)
    {
        _footer.hidden = _commentLastPage;
        
    }else if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost)
    {
        _footer.hidden = _repostLastPage;
    }
    
    return 2;
}

#pragma mark 2.第section组头部控件有多高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //MyLog(@"heightForHeaderInSection 第section组头部控件有多高");
    if (section == 0) {
        return 0;
    }else{
        return 50;
    }
}

#pragma mark 3.第section组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //MyLog(@"numberOfRowsInSection 第section组有多少行");
    return section ? [[self currentFrames] count]:1;
    
}

#pragma mark 4.每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MyLog(@"heightForRowAtIndexPath 每一行的高度");
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    }else{
        return [self.currentFrames[indexPath.row] cellHeight];
    }
}

#pragma mark 5.每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MyLog(@"cellForRowAtIndexPath 每一行显示的内容");
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"DetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //tableView.allowsSelection = NO;
        if (cell == nil) {
            cell = [[StatusDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.cellFrame = _detailFrame;
        
        return cell;
    }else if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost && _repostFrames.count > 0) {
        //转发cell
        static NSString *CellIdentifier = @"RepostCell";
        RepostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //tableView.allowsSelection = NO;
        if (cell == nil) {
            cell = [[RepostCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.myTableView = tableView;
        }
        
        cell.indexPath = indexPath;
        
        cell.cellFrame = _repostFrames[indexPath.row];
        
        return cell;
    }else if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment && _commentFrames.count > 0){
        //评论cell
        static NSString *CellIdentifier = @"CommentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //tableView.allowsSelection = NO;
        if (cell == nil) {
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.myTableView = tableView;
        }
        
        cell.indexPath = indexPath;
        cell.cellFrame = _commentFrames[indexPath.row];
        
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}

#pragma mark 判断第indexPath行的cell能不能到达选中状态
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section;
}

#pragma mark 6.第section组头部显示什么控件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //MyLog(@"viewForHeaderInSection 第section组头部显示什么控件");
    if (section == 0) {
        return nil;
    }

    _detailHeader.status = _status;
    return _detailHeader;
}

#pragma mark - DetailHeader的代理方法
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index
{
    [self.tableView reloadData];
    if (index == kDetailHeaderBtnTypeRepost ) {//点击了转发
        [self loadNewReposts];
        //MyLog(@"三角指示器的中点:%f",[header hint].center.x);
    }else if(index == kDetailHeaderBtnTypeComment){//点击了评论
        [self loadNewComments];
        //MyLog(@"三角指示器的中点:%f",[header hint].center.x);
    }else if(index == kDetailHeaderBtnTypeLike){//点击了赞
        MyLog(@"点击了赞");
    }
}

#pragma mark - 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        //上拉加载更多
        if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeRepost) {//加载更多转发数据
            [self loadMoreReposts];
        }else if(_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment){//加载更多评论
            [self loadMoreComments];
        }else{
            [_footer endRefreshing];
            //_footer.hidden = NO;
        }
    }else if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self loadNewStatus];
    }
}

#pragma mark 加载最新转发数据
- (void)loadNewReposts
{
    long long firstId = _repostFrames.count?[[_repostFrames[0] baseText] ID]:0;
    
    [StatusTool repostsWithSinceId:firstId maxId:0 statusId:_status.ID success:^(NSArray *reposts, int totalNumber, long long nextCursor){
        //MyLog(@"获取转发数据:%@, totalNum is:%d, nextCursor:%lld",reposts,totoalNumber,nextCursor);
        //1.解析最新转发frame数据
        NSMutableArray *newFrames = [self framesWithModels:reposts andFrame:[RepostCellFrame class]];
        
        _status.repostsCount = totalNumber;
        
        //2.添加数据到旧数据的前面
        if (newFrames.count > 0) {
            [_repostFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,newFrames.count)]];
        }
        MyLog(@"The nextCursor of repost is :%lld",nextCursor);
        _repostLastPage = nextCursor == 0;
        
        //3.刷新表格
        if (_repostFrames.count > 0) {
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        MyLog(@"获取转发数据失败,原因是:%@",error);
    }];
}

#pragma mark 加载最新评论数据
- (void)loadNewComments
{
    long long firstId = _commentFrames.count?[[_commentFrames[0] baseText] ID]:0;
    
    [StatusTool commentsWithSinceId:firstId maxId:0 statusId:_status.ID success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        //MyLog(@"获取评论数据:%@, totalNum is:%d, nextCursor:%lld",comments,totoalNumber,nextCursor);
        //1.解析最新评论frame数据
        NSMutableArray *newFrames = [self framesWithModels:comments andFrame:[CommentCellFrame class]];
        
        _status.commentsCount = totalNumber;
        
        //2.添加数据到旧数据的前面
        if (newFrames.count > 0) {
            [_commentFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,newFrames.count)]];
        }
        MyLog(@"The nextCursor of comments is :%lld",nextCursor);
        _commentLastPage = nextCursor == 0;
        
        //3.刷新表格
        if (_commentFrames.count > 0) {
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        MyLog(@"获取评论数据失败,原因是:%@",error);
    }];
}

#pragma mark 解析模型数据为frame数据
- (NSMutableArray *)framesWithModels:(NSArray *)models andFrame:(Class)class
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (BaseText *b in models) {
        BaseTextCellFrame *f = [[class alloc] init];
        f.baseText = b;
        [newFrames addObject:f];
    }
    return newFrames;
}

#pragma mark 加载最新微博数据
- (void)loadNewStatus
{
    [StatusTool statusWithId:_status.ID success:^(Status *status) {
        _status = status;
        _detailFrame.status = status;
        [self.tableView reloadData];
        [_header endRefreshing];
    } failure:^(NSError *error) {
        [_header endRefreshing];
        MyLog(@"获取单条微博(%lld)失败，原是:%@",_status.ID,error);
    }];
}

#pragma mark 加载更多转发数据
- (void)loadMoreReposts
{
    long long lastId = [[[_repostFrames lastObject] baseText] ID] - 1;
    [StatusTool repostsWithSinceId:0 maxId:lastId statusId:_status.ID success:^(NSArray *reposts, int totalNumber, long long nextCursor) {
        //1.解析最新评论frame数据
        NSMutableArray *newFrames = [self framesWithModels:reposts andFrame:[RepostCellFrame class]];
        
        _status.repostsCount = totalNumber;
        
        //2.添加数据到旧数据的前面
        if (newFrames.count > 0){
            [_repostFrames addObjectsFromArray:newFrames];
        }
        
        //nextCursor=0 无更多数据可加载，则隐藏上拉工具
        MyLog(@"The nextCursor of reposts is :%lld",nextCursor);
        _repostLastPage = nextCursor == 0;
        
        //3.刷新表格
        if (newFrames.count > 0){
            [self.tableView reloadData];
        }
        
        [_footer endRefreshing];
        
        _footer.hidden = _commentLastPage;
        
    } failure:^(NSError *error) {
        [_footer endRefreshing];
        MyLog(@"加载更多转发数据失败: 原因是:%@",error);
    }];
}

#pragma mark 加载更多评论数据
- (void)loadMoreComments
{
    long long lastId = [[[_commentFrames lastObject] baseText] ID] - 1;
    [StatusTool commentsWithSinceId:0 maxId:lastId statusId:_status.ID success:^(NSArray *comments, int totalNumber, long long nextCursor) {
        //1.解析最新评论frame数据
        NSMutableArray *newFrames = [self framesWithModels:comments andFrame:[CommentCellFrame class]];
        
        _status.commentsCount = totalNumber;
        
        //2.添加数据到旧数据的前面
        if (newFrames.count > 0){
            [_commentFrames addObjectsFromArray:newFrames];
        }
        
        //nextCursor=0 无更多数据可加载，则隐藏上拉工具
        MyLog(@"The nextCursor of comments is :%lld",nextCursor);
        _commentLastPage = nextCursor == 0;
        
        //3.刷新表格
        if (newFrames.count > 0){
            [self.tableView reloadData];
        }
        
        [_footer endRefreshing];
        
        _footer.hidden = _commentLastPage;

    } failure:^(NSError *error) {
        [_footer endRefreshing];
        MyLog(@"加载更多评论数据失败: 原因是:%@",error);
    }];
}

@end
