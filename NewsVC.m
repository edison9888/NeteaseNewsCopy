//
//  NewsVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC ()

@end

@implementation NewsVC

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
    UIImageView *bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 88)];
    bg.center=self.view.center;
    bg.image=[UIImage imageNamed:@"contentview_loading_background"];
    [self.view addSubview:bg];
    
    //news
    self.newsTypeView=[[NewsTypeView alloc] initWithFrame:CGRectMake(0, 64, 320, 30)];
    
    self.newsTypeView.curDelegate=self;
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 94, 320, self.view.bounds.size.height)];
    self.scrollView.contentSize=CGSizeMake(320*[self.newsTypeView.arrBtns count], self.view.bounds.size.height);
    int count = (int)[self.newsTypeView.arrBtns count];
    
    for (int i=0; i<count; i++) {
        NewsTableView *newsTable=[[NewsTableView alloc] initWithFrame:CGRectMake(320*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        newsTable.newsCatID=i+1;
        [newsTable.headerView getNewsForHeaderViewWithCat:newsTable.newsCatID];
        newsTable.headerView.delegate = self;
        newsTable.curDelegate=self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [newsTable getTheArrNewsWithType:newsTable.newsCatID AndPage:1];
            [self.scrollView addSubview:newsTable];
        });
    }
    
    self.scrollView.delegate=self;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.newsTypeView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
    NSLog(@"tablenews %d",index);
    for (UIButton *btn in self.newsTypeView.arrBtns) {
        if (btn.tag==1000+index) {
            btn.selected=YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.newsTypeView.scrollView.contentOffset=btn.frame.origin;
                self.newsTypeView.imgSelected.frame=CGRectMake(btn.frame.origin.x, 25, btn.frame.size.width, 5);
            }];
        }else{
            btn.selected=NO;
        }
    }
    
}

#pragma mark -SelectNewsTypeProtcol
- (void) selectNewsTypeMethod:(int)theType{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.alpha=0;
        self.scrollView.contentOffset=CGPointMake(320*(theType-1), 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.alpha=1;
        }];
    }];
    
    
    int index = fabs(_scrollView.contentOffset.x) / _scrollView.frame.size.width;   //当前是第几个视图
    NSLog(@"tablenews %d",index);
    
}

#pragma mark -SelectNewsAtTableProtcol
- (void) SelectNewsAtTable:(id)theNews{
    
    NewsDetailVC *newsDetail=[[NewsDetailVC alloc] init];
    newsDetail.news=theNews;
    
    [super.navigationController pushViewController:newsDetail animated:YES];
}

#pragma mark -SelectHeaderNewsProtcol
- (void) selectHeaderNewsMethod:(id)news{
    
    NewsDetailVC *newsDetail=[[NewsDetailVC alloc] init];
    newsDetail.news=news;
    
    [super.navigationController pushViewController:newsDetail animated:YES];
}
@end
