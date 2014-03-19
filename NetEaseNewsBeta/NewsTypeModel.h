//
//  NewsTypeModel.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTypeModel : NSObject
@property(nonatomic,assign)int modelid; // 比如 1 文章 2 组图 4 视频
@property(nonatomic,assign)int catid;//分类id
@property(nonatomic,strong)NSString *thumb;
@property(nonatomic,strong)NSString *name;
@end
