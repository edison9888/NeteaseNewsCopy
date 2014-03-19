//
//  HttpRequest.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-4.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
//新闻
///获取新闻内容分类列表
+ (NSString *)getNewsContentCategoryList{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsContentCategoryList",NEWS_HOST]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return  str;
}
///获取新闻模式分类列表
+ (NSString *)getNewsContentModelList{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsContentModelList",NEWS_HOST]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return  str;
}
///按新闻模型分类获取新闻列表
+ (NSString *)getNewsListByModelid:(int)modelId AndPagesize:(int)pagesize AndPage:(int)page{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsListByModelidAndPagesizeAndPage?modelid=%d&pagesize=%d&page=%d",NEWS_HOST,modelId,pagesize,page]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}
///按新闻内容分类获取新闻列表
+ (NSString *)getNewsListByCatid:(int)catid AndPagesize:(int)pagesize AndPage:(int)page{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsListByCatidAndPagesizeAndPage?catid=%d&pagesize=%d&page=%d",NEWS_HOST,catid,pagesize,page]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}
///按新闻内容分类和新闻模型分类获取新闻列表
+ (NSString *)getNewsListByModelid:(int)modelId AndCatid:(int)catid AndPagesize:(int)pagesize AndPage:(int)page{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsListByCatidAndModelidAndPagesizeAndPage?modelid=%d&catid=%d&pagesize=%d&page=%d",NEWS_HOST,modelId,catid,pagesize,page]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}
///展示新闻内容（文本）
+ (NSString *)getNewsByContentId:(int)contentid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsByContentId?contentid=%d",NEWS_HOST,contentid]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}
///展示新闻内容（图片）
+ (NSString *)getImageNewsByContentId:(int)contentid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetImageNewsByContentId?contentid=%d",NEWS_HOST,contentid]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}
///展示新闻内容（视频）
+ (NSString *)getVideoNewsByContentId:(int)contentid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetNewsByContentId?contentid=%d",NEWS_HOST,contentid]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}
///用户针对某条新闻发表意见评论
+ (NSString *)addDiscussRecordWithComment:(CommentModel *)comment{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/AddDiscussRecord",NEWS_HOST]];
    NSString *jsonContent = [CommentModel jsonWithComment:comment];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:jsonContent forKey:@"bodyParam"];
    [request startSynchronous];
    request.responseEncoding = NSUTF8StringEncoding;
    
    return [request responseString];
}
///评论列表
+ (NSString *)getDiscussRecordListByContentid:(int)contentid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/NewsWebService.asmx/GetDiscussRecordListByContentid?contentid=%d",NEWS_HOST,contentid]];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return str;
}

//用户
///用户注册
+ (NSString *)addStaffWithUser:(UserModel *)user{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/StaffWebService.asmx/AddStaff",NEWS_HOST]];
    NSString *jsonContent = [UserModel jsonWithUser:user];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:jsonContent forKey:@"bodyParam"];
    [request startSynchronous];
    request.responseEncoding = NSUTF8StringEncoding;
    
    return [request responseString];
}
///用户登录
+ (NSString *)loginWithEmail:(NSString *)mail AndPassword:(NSString *)password{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/StaffWebService.asmx/LoginWithEmail?mail=%@&Password=%@",NEWS_HOST,mail,password]];
    NSString *jsonContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return jsonContent;
}
///检查Email是否使用
+ (NSString *)isEmailExistWithEmail:(NSString *)mail{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/WebServices/StaffWebService.asmx/IsEmailExists?mail=%@",NEWS_HOST,mail]];
    NSString *jsonContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return jsonContent;
}

///新闻爆料
+ (NSString *)postNewsWithPostNews:(PostNewsModel *)postnews{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.0.43:8080/WebServices/NewsWebService.asmx/AddImageNews"]];
    NSString *jsonContent = [PostNewsModel jsonPostNews:postnews];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:jsonContent forKey:@"bodyParam"];
    [request startSynchronous];
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *response = [request responseString];
    return [request responseString];
}
@end
