//
//  VideoViewController.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageNewsCell.h"
#import "JsonParse.h"
#import "NewsDetailVideoVC.h"
#import "MJRefresh.h"

@interface VideoViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *arrNews;
@property(nonatomic,strong)UITableView *tableNews;
@property(nonatomic,assign)int curPage;

@property(nonatomic,strong)MJRefreshHeaderView *header;
@property(nonatomic,strong)MJRefreshFooterView *footer;
@end
