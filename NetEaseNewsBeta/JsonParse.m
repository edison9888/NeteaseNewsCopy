//
//  JsonParse.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "JsonParse.h"

@implementation JsonParse
//新闻
///解析新闻内容分类列表
+ (NSArray *)parseNewsContentCategoryListByJson:(NSString *)jsoncontent{
    NSMutableArray *arrList = [[NSMutableArray alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSArray *data = [dic objectForKey:@"data"];
    int count = (int)[data count];
    for (int i=0; i<count; i++) {
        NewsTypeModel *newsType = [[NewsTypeModel alloc] init];
        newsType.catid = [[[data objectAtIndex:i] objectForKey:@"Catid"] intValue];
        newsType.thumb = [[data objectAtIndex:i] objectForKey:@"Thumb"];
        newsType.name = [[data objectAtIndex:i] objectForKey:@"Name"];
        [arrList addObject:newsType];
    }
    return arrList;
}
///解析新闻模型分类列表
+ (NSArray *)parseNewsContentModelListByJson:(NSString *)jsoncontent{
    NSMutableArray *arrList = [[NSMutableArray alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSArray *data = [dic objectForKey:@"data"];
    int count = (int)[data count];
    for (int i=0; i<count; i++) {
        NewsTypeModel *newsType = [[NewsTypeModel alloc] init];
        newsType.modelid = [[[data objectAtIndex:i] objectForKey:@"Modelid"] intValue];
        newsType.thumb = [[data objectAtIndex:i] objectForKey:@"Thumb"];
        newsType.name = [[data objectAtIndex:i] objectForKey:@"Name"];
        [arrList addObject:newsType];
    }
    return arrList;
}
///解析新闻列表
+ (NSArray *)parseNewsListByJson:(NSString *)jsoncontent{
    NSMutableArray *arrNews = [[NSMutableArray alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSArray *data = [dic objectForKey:@"data"];
    for (NSDictionary *temp in data) {
        NewsModel *news = [[NewsModel alloc] init];
        [news setNewsWithDictionary:temp];
        [arrNews addObject:news];
    }
    return arrNews;
}
///解析新闻内容文本
+ (TextNewsModel *)parseTextNewsByJson:(NSString *)jsoncontent{
    TextNewsModel *news = [[TextNewsModel alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSDictionary *temp = [dic objectForKey:@"data"];
    [news setNewsWithDictionary:temp];
    return news;
}
///解析新闻内容图片
+ (ImgNewsModel *)parseImgNewsByJson:(NSString *)jsoncontent{
    ImgNewsModel *news = [[ImgNewsModel alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSDictionary *temp = [dic objectForKey:@"data"];
    [news setNewsWithDictionary:temp];
    NSArray *arrImg = [temp objectForKey:@"Imagelist"];
    NSMutableArray *arrtemp = [[NSMutableArray alloc] init];
    int count = (int)[arrImg count];
    for (int i=0; i<count; i++) {
        NSDictionary *dic = [arrImg objectAtIndex:i];
        ImageModel *img = [[ImageModel alloc] init];
        [img setImageWithDictionary:dic];
        [arrtemp addObject:img];
    }
    news.imageList = arrtemp;
    return news;
}
///解析新闻内容视频
+ (VideoNewsModel *)parseVideoNewsByJson:(NSString *)jsoncontent{
    VideoNewsModel *news = [[VideoNewsModel alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSDictionary *temp = [dic objectForKey:@"data"];
    [news setNewsWithDictionary:temp];
    return news;
}
///解析发表评论的返回值
+ (BOOL)parseAddCommentResponseByJson:(NSString *)jsoncontent{
    NSDictionary *dic = [jsoncontent JSONValue];
    int errorNum = [[dic objectForKey:@"errorNum"] intValue];
    NSString *errorMsg = [dic objectForKey:@"errorMsg"];
    if (errorNum==10000) {
        return YES;
        NSLog(@"%@",errorMsg);
    }else{
        return NO;
        NSLog(@"%@",errorMsg);
    }
}
///解析获取的评论列表
+ (NSArray *)parseCommentListByJson:(NSString *)jsoncontent{
    NSMutableArray *commmentList = [[NSMutableArray alloc] init];
    NSDictionary *dic = [jsoncontent JSONValue];
    NSArray *list = [dic objectForKey:@"data"];
    for (NSDictionary *temp in list) {
        CommentModel *comment = [[CommentModel alloc] init];
        comment.ip = [temp objectForKey:@"IP"];
        comment.nickName = [temp objectForKey:@"NickName"];
        comment.longitude = [temp objectForKey:@"Longitude"];
        comment.latitude = [temp objectForKey:@"Latitude"];
        comment.publishedTime = [temp objectForKey:@"Published"];
        comment.content = [temp objectForKey:@"Content"];
        comment.drId = [[temp objectForKey:@"DrId"] intValue];
        comment.stfId = [[temp objectForKey:@"StfId"] intValue];
        comment.contentId = [[temp objectForKey:@"ContentId"] intValue];
        [commmentList addObject:comment];
    }
    return commmentList;
}

//用户
///解析用户注册的返回值
+ (UserModel *)parseAddUserByJson:(NSString *)jsoncontent{
    NSDictionary *dic = [jsoncontent JSONValue];
    int errorNum = [[dic objectForKey:@"errorNum"] intValue];
    NSString *errorMsg = [dic objectForKey:@"errorMsg"];
    UserModel *user = [[UserModel alloc] init];
    if (errorNum==10000) {
        [user setUserInfoWithResponseDictionary:[dic objectForKey:@"data"]];
        NSLog(@"%@",errorMsg);
    }else{
        user = nil;
        NSLog(@"%@",errorMsg);
    }
    return user;
}
///解析用户登陆的返回值
+ (UserModel *)parseLoginResponseByJson:(NSString *)jsoncontent{
    
    NSDictionary *dic = [jsoncontent JSONValue];
    int errorNum = [[dic objectForKey:@"errorNum"] intValue];
    NSString *errorMsg = [dic objectForKey:@"errorMsg"];
    UserModel *user = [[UserModel alloc] init];
    if (errorNum==10000) {
        [user setUserInfoWithResponseDictionary:[dic objectForKey:@"data"]];
        NSLog(@"%@",errorMsg);
    }else{
        user = nil;
        NSLog(@"%@",errorMsg);
    }
    return user;
    
}

///解析检查email的返回值
+ (BOOL)parseMailCheckResponseByJson:(NSString *)jsoncontent{
    BOOL isSuccess = NO;
    NSDictionary *dic = [jsoncontent JSONValue];
    int errorNum = [[dic objectForKey:@"errorNum"] intValue];
    NSString *errorMsg = [dic objectForKey:@"errorMsg"];
    if (errorNum==10000) {
        isSuccess = YES;
        NSLog(@"%@",errorMsg);
    }else{
        isSuccess = NO;
        NSLog(@"%@",errorMsg);
    }
    return isSuccess;
}
///解析新闻爆料返回值
+ (BOOL)parsePostNewsResponseByJson:(NSString *)jsoncontent{
    BOOL isSuccess = NO;
    NSDictionary *dic = [jsoncontent JSONValue];
    int errorNum = [[dic objectForKey:@"errorNum"] intValue];
    NSString *errorMsg = [dic objectForKey:@"errorMsg"];
    if (errorNum==10000) {
        isSuccess = YES;
        NSLog(@"%@",errorMsg);
    }else{
        isSuccess = NO;
        NSLog(@"%@",errorMsg);
    }
    return isSuccess;
}
@end
