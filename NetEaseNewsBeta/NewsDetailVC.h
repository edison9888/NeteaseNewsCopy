//
//  NewsDetailVC.h
//  NetEaseNewsBeta
//  新闻内容视图
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 NERV. All rights reserved.
//
#define COMMENTS_FONT [UIFont systemFontOfSize:10]


#import <UIKit/UIKit.h>
#import "JsonParse.h"
#import "NewsCommentsVC.h"
#import "LocalUserManager.h"
#import "AddCommentView.h"
#import "NewsCollectionManager.h"

@interface NewsDetailVC : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,AddCommentProtcol>
@property(nonatomic,strong)NewsModel *news;
@property(nonatomic,strong)UIWebView *newsDetail;
@property(nonatomic,strong)AddCommentView *addComment;
@property(nonatomic,strong)LocalUserManager *localUser;
@property(nonatomic,strong)NewsCollectionManager *collectionNews;
@end
