//
//  ImageModel.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+ (ImageModel *)testImageModel{
    ImageModel *test = [[ImageModel alloc] init];
    test.contentid = 0;
    test.description = @"23333";
    test.frURL = @"23333.jpg";
    test.published = @"2013-09-04T14:31:27.29";
    return test;
}
- (NSDictionary *)imageModelToDic{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:self.contentid],@"Contentid",self.description,@"description",self.frURL,@"FrURL",self.published,@"Published", nil];
    return dic;
}
- (void)setImageWithDictionary:(NSDictionary *)dic{
    self.contentid = [[dic objectForKey:@"Contentid"] intValue];
    self.frid = [[dic objectForKey:@"Frid"] intValue];
    self.frURL = [NSString stringWithFormat:@"%@/UpLoad/%@",NEWS_HOST,[dic objectForKey:@"FrURL"]];
    self.published = [dic objectForKey:@"Published"];
    self.description = [dic objectForKey:@"Description"];
}
@end
