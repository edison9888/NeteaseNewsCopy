//
//  NewsDetailImageVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgNewsModel.h"
#import "JsonParse.h"

@interface NewsDetailImageVC : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)ImgNewsModel *imgNews;
@property(nonatomic,strong)UIScrollView *scrollImg;
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UILabel *lbDescription;
@end
