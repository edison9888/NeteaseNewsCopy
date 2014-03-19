//
//  PicViewController.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "PicViewController.h"

@interface PicViewController () <MJRefreshBaseViewDelegate>

@end

@implementation PicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    _tableNews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
    _tableNews.dataSource = self;
    _tableNews.delegate = self;
    _curPage = 1;
    [self.view addSubview:_tableNews];
    //MJ刷新
    [_tableNews registerClass:[ImageNewsCell class] forCellReuseIdentifier:@"ImageNewsCell"];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableNews;
    _header.delegate = self;
    [_header beginRefreshing];
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableNews;
    _footer.delegate = self;
}
- (void)getNewsWithPage:(int)page{
    NSString *jsonContent = [HttpRequest getNewsListByModelid:2 AndPagesize:5 AndPage:page];
    [_arrNews addObjectsFromArray:[JsonParse parseNewsListByJson:jsonContent]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        _arrNews = [[NSMutableArray alloc] init];
        _curPage = 1;
        [self getNewsWithPage:_curPage];
        
    } else {
        //添加
        _curPage +=1;
        [self getNewsWithPage:_curPage];
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

#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrNews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ImageNewsCell";
    ImageNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ImageNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // 设置数据
    
    ImgNewsModel *temp = self.arrNews[indexPath.row];
    [cell setCellWithImgnews:temp];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
#pragma mark -UITableViewDelegate Methods

- (void)testFooterView{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailImageVC *vc = [[NewsDetailImageVC alloc] init];
    vc.imgNews = self.arrNews[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJCollectionViewController--dealloc---");
    [_header free];
    [_footer free];
}
@end
