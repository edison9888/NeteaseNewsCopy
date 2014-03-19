//
//  NewsCollectionVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-11.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsCollectionVC.h"

@interface NewsCollectionVC ()

@end

@implementation NewsCollectionVC

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
	self.title = @"新闻收藏";
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    
    _collectionNews = [NewsCollectionManager sharedCollectionNews];
    [_collectionNews readCollectionNews];
    
    _tableInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableInfo.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableInfo.dataSource = self;
    _tableInfo.delegate = self;
    
    [self.view addSubview:_tableInfo];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)backBtnAction{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_collectionNews.arrCollectionNews count];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CollectionNewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //设置数据
    NewsModel *news = [_collectionNews.arrCollectionNews objectAtIndex:indexPath.row];
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.description;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    bg.image = [[UIImage imageNamed:@"channel_sidebar_button"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    //cell.backgroundView = bg;
    return cell;
}
    //点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [_collectionNews.arrCollectionNews removeObjectAtIndex:indexPath.row];
            [_collectionNews writeCollectionNews];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return UITableViewCellEditingStyleDelete;
    }
- (BOOL) tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return YES;
    }
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return YES;
    }
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
#pragma mark -UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailVC *vc = [[NewsDetailVC alloc] init];
    vc.news = [_collectionNews.arrCollectionNews objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
    
@end
