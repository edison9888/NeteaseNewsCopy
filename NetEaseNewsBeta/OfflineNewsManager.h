//
//  OfflineNewsManager.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-11.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "JsonParse.h"
#import "NewsTypeManager.h"
@interface OfflineNewsManager : NSObject
@property(nonatomic,strong)NSMutableDictionary *dicNews;
@property(nonatomic,strong)NewsTypeManager *newsTypes;
+ (id)sharedOfflineNewsManager;


- (BOOL)writeOfflineNews;//保存离线新闻

- (BOOL)readOfflineNews;
@end
