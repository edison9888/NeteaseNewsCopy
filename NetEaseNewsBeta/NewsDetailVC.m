//
//  NewsDetailVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsDetailVC.h"

@interface NewsDetailVC ()

@end

@implementation NewsDetailVC

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
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
	
    NSLog(@"contentID:%d",self.news.contentId);
    NSLog(@"%@",self.news.title);
    _localUser = [LocalUserManager sharedLocalUserManager];
    _collectionNews = [NewsCollectionManager sharedCollectionNews];
    [_collectionNews readCollectionNews];
   
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *bg=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 200, 100)];
    bg.center=self.view.center;
    bg.image=[UIImage imageNamed:@"contentview_loading_background"];
    [self.view addSubview:bg];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    
    //查看评论
    UIButton *comments = [[UIButton alloc] init];
    
    NSString *strComments = [NSString stringWithFormat:@"%d",self.news.comments];
    CGRect commentFrame=[strComments boundingRectWithSize:CGSizeMake(200, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
    [comments setFrame:CGRectMake(0, 0, commentFrame.size.width+60, 44)];
    [comments setBackgroundImage:[[UIImage imageNamed:@"contentview_commentbacky"] stretchableImageWithLeftCapWidth:20 topCapHeight:20] forState:UIControlStateNormal];
    [comments addTarget:self action:@selector(clickBtnComments) forControlEvents:UIControlEventTouchUpInside];
    
    comments.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    comments.titleLabel.font = [UIFont systemFontOfSize:15];
    [comments setTitle:[NSString stringWithFormat:@"%d跟帖",self.news.comments] forState:UIControlStateNormal];
    
    UIBarButtonItem *barComments=[[UIBarButtonItem alloc] initWithCustomView:comments];
    
    self.navigationItem.rightBarButtonItem=barComments;
    
    //
    UIActivityIndicatorView *loading=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loading setColor:[UIColor redColor]];
    [loading setFrame:CGRectMake(0, 0, 100, 100)];
    [loading setCenter:self.view.center];
    [loading startAnimating];
    [self.view addSubview:loading];
    
    
    //新闻内容
    _newsDetail=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-44)];
    _newsDetail.contentMode = UIViewContentModeScaleToFill;
    _newsDetail.scrollView.delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSString *jsonContent = [HttpRequest getNewsByContentId:self.news.contentId];
        TextNewsModel *news = [JsonParse parseTextNewsByJson:jsonContent];
        NSString *htmlContent=news.content;
        [_newsDetail loadHTMLString:htmlContent baseURL:nil];
        [self.view addSubview:_newsDetail];
        [loading stopAnimating];
    });
    
    
    
    //评论
    _addComment = [[AddCommentView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 40)];
    _addComment.delegate = self;
    [self.view addSubview:_addComment];
    
    //检查新闻是否收藏
    for (NewsModel *old in _collectionNews.arrCollectionNews) {
        if (_news.contentId == old.contentId){
            _addComment.btnCollection.selected = YES;
        }
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickBtnComments{
    NewsCommentsVC *commentVC = [[NewsCommentsVC alloc] init];
    commentVC.newsModel = self.news;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"start edit");
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, -216, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"send clicked");
    CommentModel *newComment = [[CommentModel alloc] init];
    newComment.contentId = self.news.contentId;
    newComment.stfId = _localUser.user.stfId;
    newComment.publishedTime = [NSString stringWithFormat:@"%@",[NSDate date]];
    newComment.content = _addComment.txtComment.text;
    NSString *jsonContent = [HttpRequest addDiscussRecordWithComment:newComment];
    [JsonParse parseAddCommentResponseByJson:jsonContent];
    
    return YES;
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    [self.view endEditing:YES];
}
#pragma mark -AddCommentProtcol
//发送评论
- (void)btnSendMethod{
    CommentModel *new = [CommentModel commentByUser:_localUser.user AndMsg:_addComment.txtComment.text];
    new.contentId = self.news.contentId;
    [JsonParse parseAddCommentResponseByJson:[HttpRequest addDiscussRecordWithComment:new]];
    
}

//收藏新闻
- (void)btnCollectionMethod{
    BOOL isSame = NO;
    if (_collectionNews.arrCollectionNews.count==0) {
        [_collectionNews.arrCollectionNews addObject:_news];
        [_collectionNews writeCollectionNews];
        _addComment.btnCollection.selected = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        for (NewsModel *old in _collectionNews.arrCollectionNews) {
            if (_news.contentId == old.contentId){
                isSame = YES;
                [_collectionNews.arrCollectionNews removeObject:old];
                [_collectionNews writeCollectionNews];
                _addComment.btnCollection.selected = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已取消收藏此新闻！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        if (!isSame) {
            [_collectionNews.arrCollectionNews addObject:_news];
            [_collectionNews writeCollectionNews];
            _addComment.btnCollection.selected = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    
}
//
- (void)beginTextComment{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, -216, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (void)endTextComment{
    
}
@end
