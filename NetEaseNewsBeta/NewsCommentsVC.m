//
//  NewsCommentsVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsCommentsVC.h"

@interface NewsCommentsVC ()

@end

@implementation NewsCommentsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _localUser = [LocalUserManager sharedLocalUserManager];
    
	_tableComments = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    _tableComments.delegate = self;
    _tableComments.dataSource = self;
    [self getComments];
    
    
    [self.view addSubview:_tableComments];
    //评论
    _addComment = [[AddCommentView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 40)];
    _addComment.delegate = self;
    [self.view addSubview:_addComment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)getComments{
    _arrComments = [[NSArray alloc] init];
    NSString *json = [HttpRequest getDiscussRecordListByContentid:self.newsModel.contentId];
    _arrComments = [JsonParse parseCommentListByJson:json];
}

#pragma mark -UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrComments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CommentsCell";
    NewsCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NewsCommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // 设置数据
    CommentModel *comment =[_arrComments objectAtIndex:indexPath.row];
    
    [cell setCellWithComment:comment];
    
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark -UITableViewDelegate Methods

- (void)testFooterView{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
#pragma mark -AddCommentProtcol
//发送评论
- (void)btnSendMethod{
    CommentModel *new = [CommentModel commentByUser:_localUser.user AndMsg:_addComment.txtComment.text];
    new.contentId = self.newsModel.contentId;
    [JsonParse parseAddCommentResponseByJson:[HttpRequest addDiscussRecordWithComment:new]];
    [self getComments];
    [self.tableComments reloadData];
}
//收藏新闻
- (void)btnCollectionMethod{
    
    
}
//
- (void)beginTextComment{
    [UIView animateWithDuration:0.2 animations:^{
        self.addComment.frame = CGRectMake(0, self.view.bounds.size.height-40-216, self.view.frame.size.width, 40);
    }];
}
- (void)endTextComment{
    
}
@end
