//
//  ImageModel.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property(nonatomic,assign)int contentid;//图片所属新闻id
@property(nonatomic,assign)int frid;//图片编号
@property(nonatomic,strong)NSString *frURL;//图片地址
@property(nonatomic,strong)NSString *published;//发布日期
@property(nonatomic,strong)NSString *description;//图片描述

+ (ImageModel *)testImageModel;
- (NSDictionary *)imageModelToDic;
- (void)setImageWithDictionary:(NSDictionary *)dic;

@end
