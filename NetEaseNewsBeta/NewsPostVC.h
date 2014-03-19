//
//  NewsPostVC.h
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-10.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalUserManager.h"
#import "PostNewsModel.h"
#import "JsonParse.h"
#import "ggPicOperation.h"

@interface NewsPostVC : UIViewController <UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UITextField *txtTitle;
@property(nonatomic,strong)UILabel *lbDescription;
@property(nonatomic,strong)UITextField *txtDescription;
@property(nonatomic,strong)UILabel *lbContent;
@property(nonatomic,strong)UITextView *txtContent;

@property(nonatomic,strong)NSMutableArray *arrImages;
@property(nonatomic,strong)NSMutableArray *arrPostImages;
@property(nonatomic,strong)UIScrollView *imageList;
@property(nonatomic,strong)UIButton *btnAddImage;

@property(nonatomic,strong)UIButton *btnPost;
@property(nonatomic,strong)NSString *postTime;
@property(nonatomic,strong)LocalUserManager *localUser;
@end
