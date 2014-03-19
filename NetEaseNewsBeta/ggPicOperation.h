//
//  ggPicOperation.h
//  HttpTestDemo
//
//  Created by gogo on 13-8-23.
//  Copyright (c) 2013年 Senlan Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ggPicOperation : NSOperation{

    NSString *imageName;
}
@property(nonatomic,strong) UIImage *theImage;
- (NSString *) UpLoading:(NSString *) imgName;
@end
