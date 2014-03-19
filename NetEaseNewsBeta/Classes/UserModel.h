//
//  UserModel.h
//  NetEaseNewsBeta
//  用户类
//  Created by TY on 14-2-27.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface UserModel : NSObject

@property(nonatomic,strong)NSString *password;//密码 必需
@property(nonatomic,strong)NSString *nickName;//昵称
@property(nonatomic,strong)NSString *stfCode;//内部编号
@property(nonatomic,strong)NSString *userName;//姓名
@property(nonatomic,assign)int gender;//性别：0-女，1-男
@property(nonatomic,assign)int depId; //部门 Id
@property(nonatomic,strong)NSString *nativePlace;//籍贯
@property(nonatomic,assign)int posId;//岗位 Id
@property(nonatomic,assign)int superId;//上级（用户）Id
@property(nonatomic,strong)NSString *education;//教育程度
@property(nonatomic,strong)NSString *workExp; //工作经历
@property(nonatomic,strong)NSString *bornDate;//出生日期
@property(nonatomic,strong)NSString *joinDate;//入职日期
@property(nonatomic,assign)int countryId; //所属国家
@property(nonatomic,assign)int qq;//QQ
@property(nonatomic,assign)int branchId; //机构id
@property(nonatomic,strong)NSString *mail;//电子邮箱 必需
@property(nonatomic,assign)int telePhone;//座机
@property(nonatomic,assign)int telePhoneExt; //分机
@property(nonatomic,assign)int mobilePhone; //手机 必需
@property(nonatomic,strong)NSString *safeQusetion;//密保问题
@property(nonatomic,strong)NSString *safeAnswer;//密保答案
@property(nonatomic,assign)int zip; //邮编
@property(nonatomic,strong)NSString *address; //地址
@property(nonatomic,strong)NSString *remark;//备注
@property(nonatomic,assign)int statusId;//状态10-在职，11-离职，12-求职，13-待业
@property(nonatomic,strong)NSString *photo;//头像
@property(nonatomic,assign)int identityCard; //身份证
@property(nonatomic,assign)int onlineStatusId;//在线状态
@property(nonatomic,strong)NSString *iP;// IPV4或IPV6地址
@property(nonatomic,assign)int cityId;//所属省市Id
@property(nonatomic,assign)int townId;//所属县区Id
@property(nonatomic,assign)int powerId;//所属授权Id
@property(nonatomic,strong)NSString *powerStartDate;//授权生效时间
@property(nonatomic,strong)NSString *powerEndDate;//授权终结时间

@property(nonatomic,assign)int stfId;



- (void)setUserInfoWithResponseDictionary:(NSDictionary *)dic;

+ (UserModel *)testUserWithMail:(NSString *)mail andPassword:(NSString *)password andMobilephone:(int)mobile;

+ (NSString *)jsonWithUser:(UserModel *)user;

@end
