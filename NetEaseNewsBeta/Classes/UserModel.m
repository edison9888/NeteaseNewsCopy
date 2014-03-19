//
//  UserModel.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-27.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setUserInfoWithResponseDictionary:(NSDictionary *)dic{
    
    self.stfId = [[dic objectForKey:@"StfId"] intValue];
    self.password = [dic objectForKey:@"Password"];
    self.nickName = [dic objectForKey:@"NickName"];
    self.stfCode = [dic objectForKey:@"StfCode"];
    self.userName = [dic objectForKey:@"UserName"];
    self.gender = [[dic objectForKey:@"Gender"] intValue];
    self.depId = [[dic objectForKey:@"DeptId"] intValue];
    self.nativePlace = [dic objectForKey:@"NativePlace"];
    self.posId = [[dic objectForKey:@"PosId"] intValue];
    self.superId = [[dic objectForKey:@"SuperId"] intValue];
    self.education = [dic objectForKey:@"Education"];
    self.workExp = [dic objectForKey:@"WorkExp"];
    self.bornDate = [dic objectForKey:@"BornDate"];
    self.joinDate = [dic objectForKey:@"JoinDate"];
    self.countryId = [[dic objectForKey:@"CountryId"] intValue];
    self.qq = [[dic objectForKey:@"QQ"] intValue];
    self.branchId = [[dic objectForKey:@"BranchId"] intValue];
    self.mail = [dic objectForKey:@"Mail"];
    self.telePhone = [[dic objectForKey:@"TelePhone"] intValue];
    self.telePhoneExt = [[dic objectForKey:@"TelePhoneExt"] intValue];
    self.mobilePhone = [[dic objectForKey:@"MobilePhone"] intValue];
    self.safeQusetion = [dic objectForKey:@"SafeQuestion"];
    self.safeAnswer = [dic objectForKey:@"SafeAnswer"];
    self.zip = [[dic objectForKey:@"Zip"] intValue];
    self.address = [dic objectForKey:@"Address"];
    self.remark = [dic objectForKey:@"Remark"];
    self.statusId = [[dic objectForKey:@"StatusId"] intValue];
    self.photo = [dic objectForKey:@"Photo"];
    self.identityCard = [[dic objectForKey:@"IdentityCard"] intValue];
    self.onlineStatusId = [[dic objectForKey:@"OnlineStatusId"] intValue];
    self.iP = [dic objectForKey:@"IP"];
    self.cityId = [[dic objectForKey:@"CityCard"] intValue];
    self.townId = [[dic objectForKey:@"TownId"] intValue];
    self.powerId = [[dic objectForKey:@"PowerId"] intValue];
    self.powerStartDate = [dic objectForKey:@"PowerStartDate"];
    self.powerEndDate = [dic objectForKey:@"PowerEndDate"];
    self.stfId = [[dic objectForKey:@"StfId"] integerValue];
}

+ (UserModel *)testUserWithMail:(NSString *)mail andPassword:(NSString *)password andMobilephone:(int)mobile{
    UserModel *user = [[UserModel alloc] init];
    user.password = password;
    user.nickName = @"Joy";
    user.stfCode = @"sc10086";
    user.userName = @"Mark";
    user.gender = 1;
    user.depId = 9;
    user.nativePlace = @"chongqing";
    user.posId = 12;
    user.superId = 100001;
    user.education = @"大学本科";
    user.workExp = @"no work";
    user.bornDate = @"1985-6-19 15:50:50";
    user.joinDate = @"2013-6-19 15:50:50";
    user.countryId = 86;
    user.qq = 231231231;
    user.branchId = 1003;
    user.mail = mail;
    user.telePhone = 21231;
    user.telePhoneExt = 23121212;
    user.mobilePhone = mobile;
    user.safeQusetion = @"妈妈叫啥";
    user.safeAnswer = @"妈妈";
    user.zip = 400000;
    user.address = @"沙坪坝区大学城";
    user.remark = @"很好的小伙";
    user.statusId = 0;
    user.photo = @"15689653233.jpg";
    user.identityCard = 123456789;
    user.onlineStatusId = 0;
    user.iP = @"192.168.1.1";
    user.cityId = 5;
    user.townId = 42;
    user.powerId = 42;
    user.powerStartDate = @"2013-06-21 16:04:53.803";
    user.powerEndDate = @"2014-06-21 16:04:53.803";
    
    return user;
}


+ (NSString *)jsonWithUser:(UserModel *)user{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.password,@"Password",user.nickName,@"NickName",user.stfCode,@"StfCode",user.userName,@"UserName",[NSNumber numberWithInt:user.gender],@"Gender",[NSNumber numberWithInt:user.depId],@"DepId",user.nativePlace,@"NativePlace",[NSNumber numberWithInt:user.posId],@"PosId",[NSNumber numberWithInt:user.superId],@"SuperId",user.education,@"Education",user.workExp,@"WorkExp",user.bornDate,@"BornDate",user.joinDate,@"JoinDate",[NSNumber numberWithInt:user.countryId],@"CountryId",[NSNumber numberWithInt:user.qq],@"QQ",[NSNumber numberWithInt:user.branchId],@"BranchId",user.mail,@"Mail",[NSNumber numberWithInt:user.telePhone],@"TelePhone",[NSNumber numberWithInt:user.telePhoneExt],@"TelePhoneExt",[NSNumber numberWithInt:user.mobilePhone],@"MobilePhone",user.safeQusetion,@"SafeQuestion",user.safeAnswer,@"SafeAnswer",[NSNumber numberWithInt:user.zip],@"Zip",user.address,@"Address",user.remark,@"Remark",[NSNumber numberWithInt:user.statusId],@"StatusId",user.photo,@"Photo",[NSNumber numberWithInt:user.identityCard],@"IdentityCard",[NSNumber numberWithInt:user.onlineStatusId],@"OnlineStatusId",user.iP,@"IP",[NSNumber numberWithInt:user.cityId],@"CityId",[NSNumber numberWithInt:user.townId],@"TownId",[NSNumber numberWithInt:user.powerId],@"PowerId",user.powerStartDate,@"PowerStartDate",user.powerEndDate,@"PowerEndDate", nil];
    
    return [dic JSONRepresentation];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.stfCode forKey:@"stfCode"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.nativePlace forKey:@"nativePlace"];
    [aCoder encodeObject:self.education forKey:@"education"];
    [aCoder encodeObject:self.workExp forKey:@"workExp"];
    [aCoder encodeObject:self.bornDate forKey:@"bornDate"];
    [aCoder encodeObject:self.joinDate forKey:@"joinDate"];
    [aCoder encodeObject:self.mail forKey:@"mail"];
    [aCoder encodeObject:self.safeQusetion forKey:@"safeQusetion"];
    [aCoder encodeObject:self.safeAnswer forKey:@"safeAnswer"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.iP forKey:@"iP"];
    [aCoder encodeObject:self.powerStartDate forKey:@"powerStartDate"];
    [aCoder encodeObject:self.powerEndDate forKey:@"powerEndDate"];
    [aCoder encodeInt:self.gender forKey:@"gender"];
    [aCoder encodeInt:self.depId forKey:@"depId"];
    [aCoder encodeInt:self.posId forKey:@"posId"];
    [aCoder encodeInt:self.superId forKey:@"superId"];
    [aCoder encodeInt:self.countryId forKey:@"countryId"];
    [aCoder encodeInt:self.qq forKey:@"qq"];
    [aCoder encodeInt:self.branchId forKey:@"branchId"];
    [aCoder encodeInt:self.telePhone forKey:@"telePhone"];
    [aCoder encodeInt:self.telePhoneExt forKey:@"telePhoneExt"];
    [aCoder encodeInt:self.mobilePhone forKey:@"mobilePhone"];
    [aCoder encodeInt:self.zip forKey:@"zip"];
    [aCoder encodeInt:self.statusId forKey:@"statusId"];
    [aCoder encodeInt:self.identityCard forKey:@"identityCard"];
    [aCoder encodeInt:self.onlineStatusId forKey:@"onlineStatusId"];
    [aCoder encodeInt:self.cityId forKey:@"cityId"];
    [aCoder encodeInt:self.townId forKey:@"townId"];
    [aCoder encodeInt:self.powerId forKey:@"powerId"];
    [aCoder encodeInt:self.stfId forKey:@"stfId"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
   
    self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
    self.password = [aDecoder decodeObjectForKey:@"password"];
    self.stfCode = [aDecoder decodeObjectForKey:@"stfCode"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.nativePlace = [aDecoder decodeObjectForKey:@"nativePlace"];
    self.education = [aDecoder decodeObjectForKey:@"education"];
    self.workExp = [aDecoder decodeObjectForKey:@"workExp"];
    self.bornDate = [aDecoder decodeObjectForKey:@"bornDate"];
    self.joinDate = [aDecoder decodeObjectForKey:@"joinDate"];
    self.mail = [aDecoder decodeObjectForKey:@"mail"];
    self.safeQusetion = [aDecoder decodeObjectForKey:@"safeQusetion"];
    self.safeAnswer = [aDecoder decodeObjectForKey:@"safeAnswer"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.remark = [aDecoder decodeObjectForKey:@"remark"];
    self.photo = [aDecoder decodeObjectForKey:@"photo"];
    self.iP = [aDecoder decodeObjectForKey:@"iP"];
    self.powerStartDate = [aDecoder decodeObjectForKey:@"powerStartDate"];
    self.powerEndDate = [aDecoder decodeObjectForKey:@"powerEndDate"];
    self.gender = [aDecoder decodeIntForKey:@"gender"];
    self.depId = [aDecoder decodeIntForKey:@"depId"];
    self.posId = [aDecoder decodeIntForKey:@"posId"];
    self.superId = [aDecoder decodeIntForKey:@"superId"];
    self.countryId = [aDecoder decodeIntForKey:@"countryId"];
    self.qq = [aDecoder decodeIntForKey:@"qq"];
    self.branchId = [aDecoder decodeIntForKey:@"branchId"];
    self.telePhone = [aDecoder decodeIntForKey:@"telePhone"];
    self.telePhoneExt = [aDecoder decodeIntForKey:@"telePhoneExt"];
    self.mobilePhone = [aDecoder decodeIntForKey:@"mobilePhone"];
    self.zip = [aDecoder decodeIntForKey:@"zip"];
    self.statusId = [aDecoder decodeIntForKey:@"statusId"];
    self.identityCard = [aDecoder decodeIntForKey:@"identityCard"];
    self.onlineStatusId = [aDecoder decodeIntForKey:@"onlineStatusId"];
    self.cityId = [aDecoder decodeIntForKey:@"cityId"];
    self.townId = [aDecoder decodeIntForKey:@"townId"];
    self.powerId = [aDecoder decodeIntForKey:@"powerId"];
    self.stfId = [aDecoder decodeIntForKey:@"stfId"];
    return self;
}
@end
