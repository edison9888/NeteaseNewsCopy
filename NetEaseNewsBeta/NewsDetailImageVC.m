//
//  NewsDetailImageVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsDetailImageVC.h"

@interface NewsDetailImageVC ()

@end

@implementation NewsDetailImageVC

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
    self.view.backgroundColor = [UIColor blackColor];
    //导航栏设置
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    //获取图片
    _imgNews = [JsonParse parseImgNewsByJson:[HttpRequest getImageNewsByContentId:_imgNews.contentId]];
    int count = (int)[_imgNews.imageList count];
    
    //图片
	_scrollImg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _scrollImg.contentSize = CGSizeMake(320*count, 200);
    _scrollImg.pagingEnabled = YES;
    _scrollImg.delegate = self;
    _scrollImg.showsHorizontalScrollIndicator = NO;
    _scrollImg.showsVerticalScrollIndicator = NO;
    //_scrollImg.contentOffset = CGPointMake(0, 64);
    _scrollImg.directionalLockEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImages)];
    [_scrollImg addGestureRecognizer:tap];
    
    [self.view addSubview:_scrollImg];
    //新闻标题
    _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-100, self.view.bounds.size.width, 30)];
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    _lbTitle.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_lbTitle];
    _lbDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-70, self.view.bounds.size.width, 60)];
    _lbDescription.numberOfLines = 3;
    _lbDescription.textAlignment = NSTextAlignmentCenter;
    _lbDescription.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_lbDescription];
    if ([_imgNews.imageList count]>0) {
        for (int i=0; i<count; i++) {
            NSURL *url = [NSURL URLWithString:[[_imgNews.imageList objectAtIndex:i] frURL]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (data) {
                UIImage *img = [UIImage imageWithData:data];
                //CGSize size = _scrollImg.bounds.size;
                UIImageView *imgView = [[UIImageView alloc] init];
                CGFloat height = (320/img.size.width)*img.size.height;
                imgView.frame = CGRectMake(320*i, _scrollImg.center.y-(height/2), 320, height);
                imgView.image = img;
                [_scrollImg addSubview:imgView];
            }
        }
        _lbTitle.text = [NSString stringWithFormat:@"%@ 1/%d",_imgNews.title,[_imgNews.imageList count]];
        _lbDescription.text = [[_imgNews.imageList objectAtIndex:0] description];
        
    }else{
        _lbTitle.text = _imgNews.title;
    
        NSURL *url = [NSURL URLWithString:_imgNews.thumb];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
                UIImage *img = [UIImage imageWithData:data];
                //CGSize size = _scrollImg.bounds.size;
                UIImageView *imgView = [[UIImageView alloc] init];
                CGFloat height = (320/img.size.width)*img.size.height;
                imgView.frame = CGRectMake(0, _scrollImg.center.y-(height/2), 320, height);
                imgView.image = img;
                [_scrollImg addSubview:imgView];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)tapImages{
    NSLog(@"tap image");
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }else{
        self.navigationController.navigationBarHidden = YES;
    }
}

- (void)backBtnAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
    NSLog(@"%d",index);
    if ([_imgNews.imageList count]>0) {
    _lbTitle.text = [NSString stringWithFormat:@"%@ %d/%d",_imgNews.title,index+1,[_imgNews.imageList count]];
    _lbDescription.text = [[_imgNews.imageList objectAtIndex:index] description];
    }
}
@end
