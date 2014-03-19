//
//  NewsModel.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-19.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,assign)int contentId;//新闻ID
@property(nonatomic,assign)int modelid; // 比如 1 文章 2 组图 4 视频
@property(nonatomic,assign)int catid;//分类id
@property(nonatomic,strong)NSString *title; //新闻标题
@property(nonatomic,strong)NSString *description;
@property(nonatomic,strong)NSString *thumb;
@property(nonatomic,strong)NSString *published;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *video;
@property(nonatomic,assign)int playtime;
@property(nonatomic,assign)int topicid;
@property(nonatomic,assign)int comments;

- (void)setNewsWithDictionary:(NSDictionary *)dic;

@end
