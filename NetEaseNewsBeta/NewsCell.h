//
//  NewsCell.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define DESCRIPTION_FONT [UIFont systemFontOfSize:14]
#define COMMENTS_FONT [UIFont systemFontOfSize:10]

#import <UIKit/UIKit.h>
#import "NewsModel.h"


@interface NewsCell : UITableViewCell

@property(nonatomic,strong)NewsModel *news;
@property(nonatomic,strong)UIImageView *imgThumb;
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UILabel *lbDescription;
@property(nonatomic,strong)UILabel *lbComments;

@end
