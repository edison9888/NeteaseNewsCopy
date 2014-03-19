//
//  NewsVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTypeView.h"
#import "NewsCell.h"
#import "NewsHeaderView.h"
#import "NewsTableView.h"
#import "NewsDetailVC.h"
#import "JsonParse.h"

@interface NewsVC : UIViewController<UIScrollViewDelegate,SelectNewsTypeProtcol,SelectNewsAtTableProtcol,SelectHeaderNewsProtcol>


@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NewsTypeView *newsTypeView;
@property(nonatomic,strong)NSMutableArray *arrNews;
@property(nonatomic,strong)UITableView *TableNews;
@property(nonatomic,strong)NewsHeaderView *headerView;
@property(nonatomic,assign)int newsCatID;

@end
