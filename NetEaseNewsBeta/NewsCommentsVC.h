//
//  NewsCommentsVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-28.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonParse.h"
#import "AddCommentView.h"
#import "NewsCommentsCell.h"
#import "LocalUserManager.h"

@interface NewsCommentsVC : UIViewController <UITableViewDataSource,UITableViewDelegate,AddCommentProtcol>
@property(nonatomic,strong)UITableView *tableComments;
@property(nonatomic,strong)NewsModel *newsModel;
@property(nonatomic,strong)NSArray *arrComments;
@property(nonatomic,strong)AddCommentView *addComment;
@property(nonatomic,strong)LocalUserManager *localUser;
@end
