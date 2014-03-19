//
//  JsonParse.h
//  NetEaseNewsBeta
//  解析json数据
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"


@interface JsonParse : NSObject

//新闻
///解析新闻内容分类列表
+ (NSArray *)parseNewsContentCategoryListByJson:(NSString *)jsoncontent;
///解析新闻模型分类列表
+ (NSArray *)parseNewsContentModelListByJson:(NSString *)jsoncontent;
///解析新闻列表
+ (NSArray *)parseNewsListByJson:(NSString *)jsoncontent;
///解析新闻内容文本
+ (TextNewsModel *)parseTextNewsByJson:(NSString *)jsoncontent;
///解析新闻内容图片
+ (ImgNewsModel *)parseImgNewsByJson:(NSString *)jsoncontent;;
///解析新闻内容视频
+ (VideoNewsModel *)parseVideoNewsByJson:(NSString *)jsoncontent;
///解析发表评论的返回值
+ (BOOL)parseAddCommentResponseByJson:(NSString *)jsoncontent;
///解析获取的评论列表
+ (NSArray *)parseCommentListByJson:(NSString *)jsoncontent;

//用户
///解析用户注册的返回值
+ (UserModel *)parseAddUserByJson:(NSString *)jsoncontent;
///解析用户登陆的返回值
+ (UserModel *)parseLoginResponseByJson:(NSString *)jsoncontent;
///解析检查email的返回值
+ (BOOL)parseMailCheckResponseByJson:(NSString *)jsoncontent;
///解析新闻爆料返回值
+ (BOOL)parsePostNewsResponseByJson:(NSString *)jsoncontent;
@end
