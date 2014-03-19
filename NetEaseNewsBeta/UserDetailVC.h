//
//  UserDetailVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-10.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalUserManager.h"
#import "JsonParse.h"

@interface UserDetailVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *header;
@property(nonatomic,strong)UITableView *tableInfo;
@property(nonatomic,strong)UIView *footer;
@property(nonatomic,strong)LocalUserManager *localUser;

@property(nonatomic,strong)NSArray *arrKeys;
@property(nonatomic,strong)NSDictionary *dic;
@end
