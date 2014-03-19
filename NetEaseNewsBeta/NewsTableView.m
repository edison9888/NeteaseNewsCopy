//
//  NewsTableView.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsTableView.h"

@implementation NewsTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.curPage = 0;
        self.arrNews = [[NSMutableArray alloc] init];
        self.tableNews=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 386)];
        
        [self.tableNews setDataSource:self];
        [self.tableNews setDelegate:self];
        [self addSubview:self.tableNews];
        self.headerView = [[NewsHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        
        self.tableNews.tableHeaderView = self.headerView;
        
        //MJ刷新
        [self.tableNews registerClass:[NewsCell class] forCellReuseIdentifier:@"ImageNewsCell"];
        self.header = [MJRefreshHeaderView header];
        self.header.scrollView = self.tableNews;
        self.header.delegate = self;
        
        self.footer = [MJRefreshFooterView footer];
        self.footer.scrollView = self.tableNews;
        self.footer.delegate = self;
        
        
        self.loadingImage = [[UIImageView alloc] initWithFrame:self.bounds];
        self.loadingImage.image = [UIImage imageNamed:@"top_navigation_background"];
        //[self addSubview:self.loadingImage];
        
        
        
    }
    return self;
}
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableNews reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}
#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.添加假数据
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        //刷新
        self.arrNews = [[NSMutableArray alloc] init];
        self.curPage = 1;
        [self getTheArrNewsWithType:self.newsCatID AndPage:self.curPage];
        
    } else {
        //添加
        self.curPage +=1;
        [self getTheArrNewsWithType:self.newsCatID AndPage:self.curPage];
    }
    // 2.2秒后刷新表格UI
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    switch (state) {
        case MJRefreshStateNormal:
            NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [self didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTheArrNewsWithType:(int)type AndPage:(int)page{
    NSString *jsonContent = [HttpRequest getNewsListByCatid:type AndPagesize:5 AndPage:page];
    [self.arrNews addObjectsFromArray:[JsonParse parseNewsListByJson:jsonContent]];
}
#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrNews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // 设置数据
    NewsModel *temp = self.arrNews[indexPath.row];
    [cell setNews:temp];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark -UITableViewDelegate Methods

- (void)testFooterView{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.curDelegate SelectNewsAtTable:self.arrNews[indexPath.row]];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

#pragma mark -SelectNewsAtTableProtcol Methods
- (void) SelectNewsAtTable:(id)theNews{
    
}

@end
