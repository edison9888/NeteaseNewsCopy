//
//  PostNewsModel.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsModel.h"
#import "ImageModel.h"
#import "SBJson.h"

@interface PostNewsModel : NewsModel
@property(nonatomic,strong)NSArray *imageList;



+ (NSString *)jsonPostNews:(PostNewsModel *)postnews;

@end
