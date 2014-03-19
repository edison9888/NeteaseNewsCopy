//
//  NewsCollectionVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-11.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCollectionManager.h"
#import "NewsDetailVC.h"

@interface NewsCollectionVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
    
@property(nonatomic,strong)UITableView *tableInfo;
@property(nonatomic,strong)NewsCollectionManager *collectionNews;


@end
