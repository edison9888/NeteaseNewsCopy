//
//  NewsHeaderView.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 NERV. All rights reserved.
//
@protocol SelectHeaderNewsProtcol <NSObject>
@required
- (void) selectHeaderNewsMethod:(id)news;
@end
#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "SBJson.h"
#import "JsonParse.h"

@interface NewsHeaderView : UIView<UIScrollViewDelegate>

@property(weak,nonatomic)id<SelectHeaderNewsProtcol> delegate;
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *page;
@property(strong,nonatomic)NSArray *arrNews;
@property(assign,nonatomic)int type;
- (void)getNewsForHeaderViewWithCat:(int)catid;

@end
