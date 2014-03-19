//
//  NewsPostVC.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-3-10.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsPostVC.h"

@interface NewsPostVC ()

@end

@implementation NewsPostVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _localUser = [LocalUserManager sharedLocalUserManager];
    _arrPostImages = [[NSMutableArray alloc] init];
    _arrImages = [[NSMutableArray alloc] init];
    self.title = @"我的爆料";
	[self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back-1"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem=back;
    self.view.backgroundColor = [UIColor whiteColor];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    _postTime = [dateFormatter stringFromDate:[NSDate date]];
    //新闻内容
    //标题
    _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 70, 25)];
    _lbTitle.text = @"标题：";
    _txtTitle = [[UITextField alloc] initWithFrame:CGRectMake(80, 90, 200, 25)];
    _txtTitle.borderStyle = UITextBorderStyleLine;
    _txtTitle.placeholder = @"请填写爆料标题";
    [self.view addSubview:_lbTitle];
    [self.view addSubview:_txtTitle];
    //描述
    _lbDescription = [[UILabel alloc] initWithFrame:CGRectMake(20, 125, 70, 25)];
    _lbDescription.text = @"描述：";
    _txtDescription = [[UITextField alloc] initWithFrame:CGRectMake(80, 125, 200, 25)];
    _txtDescription.borderStyle = UITextBorderStyleLine;
    _txtDescription.placeholder = @"请填写爆料描述";
    [self.view addSubview:_lbDescription];
    [self.view addSubview:_txtDescription];
    //内容
    _lbContent = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 70, 25)];
    _lbContent.text = @"内容：";
    _txtContent = [[UITextView alloc] initWithFrame:CGRectMake(80, 160, 200, 100)];
    _txtContent.layer.borderWidth = 1;
    _txtContent.layer.borderColor = [[UIColor blackColor] CGColor];
    _txtContent.text = @"请填写爆料内容";
    _txtContent.textColor = [UIColor grayColor];
    _txtContent.delegate = self;
    [self.view addSubview:_txtContent];
    [self.view addSubview:_lbContent];
    
    
    //图片
    _imageList = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 280, 280, 60)];
    _imageList.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_imageList];
    _btnAddImage = [[UIButton alloc] initWithFrame:CGRectMake(20, 345, 100, 20)];
    _btnAddImage.backgroundColor = [UIColor yellowColor];
    [_btnAddImage addTarget:self action:@selector(getImg:) forControlEvents:UIControlEventTouchUpInside];
    [_btnAddImage setTitle:@"添加图片" forState:UIControlStateNormal];
    [self.view addSubview:_btnAddImage];
    
    
    _btnPost = [[UIButton alloc] initWithFrame:CGRectMake(60, 400, 200, 30)];
    [_btnPost setTitle:@"我要爆料" forState:UIControlStateNormal];
    [_btnPost setBackgroundColor:[UIColor redColor]];
    [_btnPost addTarget:self action:@selector(postNews) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPost];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)backBtnAction{
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)postNews{
    NSLog(@"post news");
    //检查内容是否为空
    if (![self checkEmpty]) {
        NSLog(@"begin post news");
        //开始上传
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        
        PostNewsModel *post = [[PostNewsModel alloc] init];
        post.source = [NSString stringWithFormat:@"%d",_localUser.user.stfId];
        post.title = _txtTitle.text;
        post.description = _txtDescription.text;
        post.content = _txtContent.text;
        post.published = strDate;
        post.imageList = _arrImages;
        post.thumb = [NSString stringWithFormat:@"test0%@.jpg",_postTime];
        [self postImages];
        NSString *json = [HttpRequest postNewsWithPostNews:post];
        BOOL isSuccess = [JsonParse parsePostNewsResponseByJson:json];
        if (isSuccess) {
            NSLog(@"post success");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"上传成功" message:@"爆料成功！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            NSLog(@"post failed");
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"上传失败" message:@"请完整爆料信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
- (void)postImages{
    int count = (int)[_arrPostImages count];
    for (int i=0; i<count; i++) {
        ggPicOperation *postPic = [[ggPicOperation alloc] init];
        ImageModel *upimg = [[ImageModel alloc] init];
        upimg = [_arrImages objectAtIndex:i];
        postPic.theImage = [_arrPostImages objectAtIndex:i];
        [postPic UpLoading:upimg.frURL];
    }
}
- (BOOL) checkEmpty{
    //检查内容是否为空
    BOOL isEmpty = NO;
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UITextField class]]) {
            UITextField *t = obj;
            if (t.text.length==0) {
                
                isEmpty = YES;
            }
        }else if ([obj isKindOfClass:[UITextView class]]){
            UITextView *t = obj;
            if (t.text.length==0 || [t.text isEqualToString:@"请填写爆料内容"]) {
                
                isEmpty = YES;
            }
        }
    }
    return isEmpty;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
    
-(void)getImg:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择一张图片吧" delegate:self  cancelButtonTitle:@"取消" destructiveButtonTitle:@"立即拍照上传" otherButtonTitles:@"从手机相册选取",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        //    [actionSheet setDelegate:self];
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];
        
}
#pragma mark UIActionSheet协议
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex ==0)
        {   UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setAllowsEditing:YES];
            [imgPicker setDelegate:self];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self.navigationController presentModalViewController:imgPicker animated:YES];
            
        }
        if (buttonIndex ==1) {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setAllowsEditing:YES];
            [imgPicker setDelegate:self];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self.navigationController presentModalViewController:imgPicker animated:YES];
            
        }
        else
        return;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    
    ImageModel *newImg = [[ImageModel alloc] init];
    newImg.contentid = 0;
    newImg.description = @"test";
    newImg.frURL = [NSString stringWithFormat:@"test%d%@.jpg",[_arrImages count],_postTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    newImg.published = strDate;
    [_arrImages addObject:newImg];
    [_arrPostImages addObject:image];
    [_imageList setContentSize:CGSizeMake(_imageList.frame.size.width*[_arrImages count], _imageList.frame.size.height)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(_imageList.frame.size.width*([_arrImages count]-1), 0, _imageList.frame.size.width, _imageList.frame.size.height)];
    img.image = image;
    
    [_imageList addSubview:img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    return;
}
#pragma mark -UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if ([_txtContent.text isEqualToString:@"请填写爆料内容"]) {
        _txtContent.textColor = [UIColor blackColor];
        _txtContent.text = @"";
    }
    
    return YES;
}
@end
