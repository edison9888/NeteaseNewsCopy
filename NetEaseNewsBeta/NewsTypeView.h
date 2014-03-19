//
//  NewsTypeView.h
//  NetEaseNewsBeta
//  新闻类型选择视图
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 NERV. All rights reserved.
//
#define CAT_NAME_FONT [UIFont systemFontOfSize:25] //内容字体
@protocol SelectNewsTypeProtcol <NSObject>
@required
- (void) selectNewsTypeMethod:(int)theType;
@end

#import <UIKit/UIKit.h>
#import "NewsTypeModel.h"
#import "JsonParse.h"
#import "NewsTypeManager.h"

@interface NewsTypeView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIButton *btnAddType;
@property (strong,nonatomic)NSMutableArray *arrTypes;
@property (strong,nonatomic)NSMutableArray *arrUnselectedTypes;
@property (strong,nonatomic)NSMutableArray *arrBtns;
@property (strong,nonatomic)UIView *allTypeView;
@property (weak,nonatomic)id<SelectNewsTypeProtcol> curDelegate;
@property (strong,nonatomic)UIImageView *imgSelected;
@property (strong,nonatomic)NewsTypeManager *newsTypes;

@property (strong,nonatomic)UICollectionView *collectionView;

@end
