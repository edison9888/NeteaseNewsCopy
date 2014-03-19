//
//  NewsDetailVideoVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FFmpegDecoder/FrameExtractor.h>//引入视频解码类
#import "VideoNewsModel.h"

@interface NewsDetailVideoVC : UIViewController<CGImageBufferDelegate,UITextFieldDelegate>{
        NSTimer* timer;//计时器控制播放
        float lastFrameTime;//最后一帧
}
@property(nonatomic,strong)VideoNewsModel *videoNews;
@property(nonatomic,strong)UIImageView *imageView;
@property (nonatomic,retain) FrameExtractor *video;
    
-(void)displayNextFrame:(NSTimer *)timer;
    
@end
