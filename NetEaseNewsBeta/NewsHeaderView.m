//
//  NewsHeaderView.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsHeaderView.h"

@implementation NewsHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)getNewsForHeaderViewWithCat:(int)catid{
    
    self.arrNews = [JsonParse parseNewsListByJson:[HttpRequest getNewsListByCatid:catid AndPagesize:3 AndPage:1]];
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    self.scrollView.delegate=self;
    [self.scrollView setContentSize:CGSizeMake(320*[self.arrNews count], 150)];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    int count=(int)[self.arrNews count];
    
    for (int i=0;i<count;i++) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 150)];
        UIImageView *img=[[UIImageView alloc] initWithFrame:view.bounds];
        img.image = [UIImage imageNamed:@"contentview_imagebg_logo"];
        UIImageView *imgCover=[[UIImageView alloc] initWithFrame:view.bounds];
        imgCover.image=[[UIImage imageNamed:@"mashup_headimage_cover"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(60, 125, 200, 20)];
        UILabel *model=[[UILabel alloc] initWithFrame:CGRectMake(10, 125, 40, 20)];
        model.text=@"头条";
        NewsModel *hNews = [self.arrNews objectAtIndex:i];
        title.text=hNews.title;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSURL *imgUrl=[NSURL URLWithString:hNews.thumb];
            NSData *imgData=[NSData dataWithContentsOfURL:imgUrl];
            if (imgData) {
                img.image=[UIImage imageWithData:imgData];
            }
        });
        model.textColor=[UIColor whiteColor];
        model.backgroundColor=[UIColor redColor];
        model.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor whiteColor];
        [view addSubview:img];
        [view addSubview:imgCover];
        [view addSubview:model];
        [view addSubview:title];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderNews)];
        [view addGestureRecognizer:tap];
        [self.scrollView addSubview:view];
    }
    
    self.page=[[UIPageControl alloc] initWithFrame:CGRectMake(260, 125, 60, 20)];
    self.page.numberOfPages=[self.arrNews count];
    self.page.currentPageIndicatorTintColor=[UIColor redColor];
    [self addSubview:self.scrollView];
    [self addSubview:self.page];
}

- (void)tapHeaderNews{
    NSLog(@"tap news %d",self.page.currentPage);
    NewsModel *temp = [self.arrNews objectAtIndex:self.page.currentPage];
    if ([self respondsToSelector:@selector(selectHeaderNewsMethod:)]) {
        [self.delegate selectHeaderNewsMethod:temp];
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
    NSLog(@"%d",index);
    self.page.currentPage = index;
}
#pragma mark -SelectHeaderNewsProtcol
- (void) selectHeaderNewsMethod:(id)news{
    
}

@end
