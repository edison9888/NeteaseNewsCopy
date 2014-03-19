//
//  NewsDetailVideoVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-7.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsDetailVideoVC.h"

@interface NewsDetailVideoVC ()

@end

@implementation NewsDetailVideoVC

    @synthesize imageView;
    @synthesize video;
    
    
- (void)viewDidLoad
    {
        [super viewDidLoad];
        
        self.view.backgroundColor = [UIColor whiteColor];
        imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 240)];
        
        //给imageView添加手势
        UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap1:)];
        tapRecognizer1.numberOfTapsRequired = 1;//单击
        UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap2:)];
        tapRecognizer2.numberOfTapsRequired = 2;//双击
        [self.imageView addGestureRecognizer:tapRecognizer1];
        [self.imageView addGestureRecognizer:tapRecognizer2];
        [imageView setUserInteractionEnabled:YES];
        [imageView setAutoresizesSubviews:YES];
        [self.view addSubview:imageView];
        
        //播放视频
        @try {
            if (![self.videoNews.video isEqualToString:@""]) {
                //解码器实例化
                
                self.video = [[FrameExtractor alloc] initWithVideo:self.videoNews.video];
                self.video.cgimageDelegate = self;
                // 设置视频输出宽和高
                video.outputWidth = 320;
                video.outputHeight = 240;
                lastFrameTime = -1;
                [video setupCgimageSession];
                // 查看视频源属性
                NSLog(@"video duration: %f",video.duration);
                NSLog(@"video size: %d x %d", video.sourceWidth, video.sourceHeight);
            } else {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入有效的视频URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];

            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception reason=%@, description=%@",exception.reason,exception.description);
        }
        @finally {
            
        }

    }
    
- (void) handleTap1:(UITapGestureRecognizer*) recognizer {
    [UIView beginAnimations:@"FullScreen" context:nil];
    
    [imageView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    self.imageView.frame = CGRectMake(0, 0, 320, 480);
    [self.view bringSubviewToFront:imageView];
    [UIView commitAnimations];
}
    
- (void) handleTap2:(UITapGestureRecognizer*) recognizer {
    [UIView beginAnimations:@"Normal" context:nil];
    [imageView setTransform:CGAffineTransformMakeRotation(2*M_PI)];
    self.imageView.frame = CGRectMake(0, 100, 320, 240);
    [self.view sendSubviewToBack:imageView];
    [UIView commitAnimations];
}
    
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    

    
-(void)displayNextFrame:(NSTimer *)timer{
    
}
    
-(void)didOutputCGImageBuffer:(NSTimer *)timer {
    [video stepFrame];
  	imageView.image = video.currentImage;
}
    

@end
