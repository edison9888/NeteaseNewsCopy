//
//  NewsTableView.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-21.
//  Copyright (c) 2014年 NERV. All rights reserved.
//
@protocol SelectNewsAtTableProtcol <NSObject>
@required
- (void) SelectNewsAtTable:(id)theNews;
@end


#import <UIKit/UIKit.h>
#import "NewsTypeView.h"
#import "NewsCell.h"
#import "NewsHeaderView.h"
#import "JsonParse.h"
#import "MJRefresh.h"



@interface NewsTableView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MJRefreshBaseViewDelegate>


@property(nonatomic,strong)NSMutableArray *arrNews;
@property(nonatomic,strong)UITableView *tableNews;
@property(nonatomic,strong)NewsHeaderView *headerView;
@property(nonatomic,assign)int newsCatID;
@property(nonatomic,weak)id<SelectNewsAtTableProtcol> curDelegate;
@property(nonatomic,assign)BOOL reloading;
@property(nonatomic,strong)UIImageView *loadingImage;

@property(nonatomic,strong)MJRefreshHeaderView *header;
@property(nonatomic,strong)MJRefreshFooterView *footer;
@property(nonatomic,assign)int curPage;

- (void)getTheArrNewsWithType:(int)type AndPage:(int)page;

@end
