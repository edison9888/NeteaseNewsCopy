//
//  HttpRequest.h
//  NetEaseNewsBeta
//  http请求类
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "NewsModel.h"
#import "TextNewsModel.h"
#import "ImgNewsModel.h"
#import "VideoNewsModel.h"
#import "NewsTypeModel.h"
#import "CommentModel.h"
#import "UserModel.h"
#import "ImageModel.h"
#import "PostNewsModel.h"

@interface HttpRequest : NSObject

//新闻
///获取新闻内容分类列表
+ (NSString *)getNewsContentCategoryList;
///获取新闻模式分类列表
+ (NSString *)getNewsContentModelList;
///按新闻模型分类获取新闻列表
+ (NSString *)getNewsListByModelid:(int)modelId AndPagesize:(int)pagesize AndPage:(int)page;
///按新闻内容分类获取新闻列表
+ (NSString *)getNewsListByCatid:(int)catid AndPagesize:(int)pagesize AndPage:(int)page;
///按新闻内容分类和新闻模型分类获取新闻列表
+ (NSString *)getNewsListByModelid:(int)modelId AndCatid:(int)catid AndPagesize:(int)pagesize AndPage:(int)page;
///展示新闻内容（文本）
+ (NSString *)getNewsByContentId:(int)contentid;
///展示新闻内容（图片）
+ (NSString *)getImageNewsByContentId:(int)contentid;
///展示新闻内容（视频）
+ (NSString *)getVideoNewsByContentId:(int)contentid;
///用户针对某条新闻发表意见评论
+ (NSString *)addDiscussRecordWithComment:(CommentModel *)comment;
///评论列表
+ (NSString *)getDiscussRecordListByContentid:(int)contentid;

//用户
///用户注册
+ (NSString *)addStaffWithUser:(UserModel *)user;
///用户登录
+ (NSString *)loginWithEmail:(NSString *)mail AndPassword:(NSString *)password;
///检查Email是否使用
+ (NSString *)isEmailExistWithEmail:(NSString *)mail;
///新闻爆料
+ (NSString *)postNewsWithPostNews:(PostNewsModel *)postnews;
@end
