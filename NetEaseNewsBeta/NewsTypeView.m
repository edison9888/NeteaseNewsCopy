//
//  NewsTypeView.m
//  NetEaseNewsBeta
//
//  Created by TY on 14-2-20.
//  Copyright (c) 2014年 NERV. All rights reserved.
//

#import "NewsTypeView.h"

@implementation NewsTypeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //所有新闻类型
        self.allTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, -480, 320, 300)];
        self.allTypeView.alpha=1;
        self.allTypeView.backgroundColor=[UIColor grayColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(60, 20);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 20;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) collectionViewLayout:layout];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TypeCollectionCell"];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor yellowColor];
        [self.allTypeView addSubview:self.collectionView];
        //编辑按钮
        UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 40, 30)];
        [btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        btnDelete.backgroundColor = [UIColor redColor];
        [self addSubview:btnDelete];
        //
        self.arrBtns=[[NSMutableArray alloc] init];
        self.arrTypes=[[NSMutableArray alloc] init];
        _newsTypes = [NewsTypeManager sharedNewsTypes];
        [_newsTypes readNewsTypes];
        if ([_newsTypes.arrTypes count]==0) {
            [self.arrTypes setArray:[JsonParse parseNewsContentCategoryListByJson:[HttpRequest getNewsContentCategoryList]]];
            _newsTypes.arrTypes = self.arrTypes;
            [_newsTypes writeNewsTypes];
        }else{
            self.arrTypes = _newsTypes.arrTypes;
        }
        
        int count = (int)[self.arrTypes count];
        
        CGFloat scrollViewWidth=0;
        for (int i=0; i<count; i++) {
            NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:CAT_NAME_FONT,NSFontAttributeName, nil];
            NewsTypeModel *type = [[NewsTypeModel alloc] init];
            type=[self.arrTypes objectAtIndex:i];
            CGRect catFrame=[type.name boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
            
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(scrollViewWidth, 0, catFrame.size.width, catFrame.size.height)];
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            [btn setTitle:type.name forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cola_indicator"]] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTag:1000+i];
            if (i==0) {
                [btn setSelected:YES];
            }
            [self.arrBtns addObject:btn];
            scrollViewWidth+=catFrame.size.width;
            if (i==0) {
                self.imgSelected = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, catFrame.size.width, 5)];
                self.imgSelected.image = [[UIImage imageNamed:@"cola_indicator"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
            }
        }
        
        //新闻类型
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentSize=CGSizeMake(scrollViewWidth, 30);
        for (int i=0; i<count; i++) {
            [self.scrollView addSubview:[self.arrBtns objectAtIndex:i]];
        }
        [self.scrollView addSubview:self.imgSelected];
        self.scrollView.showsHorizontalScrollIndicator=NO;
        
        
        //添加新闻类型按钮
        self.btnAddType = [UIButton buttonWithType:UIButtonTypeSystem];
//        self.btnAddType = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 30)];
        self.btnAddType.frame=CGRectMake(280, 0, 40, 30);
        [self.btnAddType setBackgroundColor:[UIColor whiteColor]];
        [self.btnAddType setImage:[UIImage imageNamed:@"channel_nav_arrow"] forState:UIControlStateNormal];
        [self.btnAddType addTarget:self action:@selector(setTheBtnAddType) forControlEvents:UIControlEventTouchUpInside];
        self.btnAddType.transform=CGAffineTransformMakeRotation(M_PI);
        self.btnAddType.tintColor=[UIColor redColor];
        [self.btnAddType setSelected:NO];
        self.btnAddType.layer.shadowOpacity=0;
        self.btnAddType.layer.shadowColor=[UIColor blackColor].CGColor;
        self.btnAddType.layer.shadowOffset=CGSizeMake(-20, 20);
        
        
        [self addSubview:self.allTypeView];
        [self addSubview:self.scrollView];
        
        [self addSubview:self.btnAddType];
    }
    return self;
}

- (void)setTheBtnAddType{
    //UIImage *imgUp=[UIImage imageNamed:@"channel_nav_arrow"];
    if (!self.btnAddType.isSelected) {
        self.btnAddType.transform=CGAffineTransformRotate(self.btnAddType.transform, M_PI);
        [UIView animateWithDuration:1 animations:^{
            self.scrollView.alpha = 0;
            self.allTypeView.alpha = 1;
            [self.allTypeView setFrame:CGRectMake(0, 30, self.bounds.size.width, 380)];
            self.frame = CGRectMake(0, 64, 320, 330);
        } completion:^(BOOL finished) {
            
        }];
        [self.btnAddType setSelected:YES];
    }else{
        self.btnAddType.transform=CGAffineTransformRotate(self.btnAddType.transform, M_PI);
        [UIView animateWithDuration:1 animations:^{
            self.scrollView.alpha = 1;
            self.allTypeView.alpha = 0;
            [self.allTypeView setFrame:CGRectMake(0, -300, self.bounds.size.width, 386)];
            self.frame = CGRectMake(0, 64, 320, 30);
        } completion:^(BOOL finished) {
            
        }];
        [self.btnAddType setSelected:NO];

    }
    
    
}

- (void)btnTypeAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if (!btn.selected) {
        btn.selected=YES;
        if (btn.tag>1000) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset=CGPointMake(btn.frame.origin.x-50, btn.frame.origin.y);
            self.imgSelected.frame=CGRectMake(btn.frame.origin.x, 25, btn.frame.size.width, 5);
        }]; 
        }else{
            self.imgSelected.frame=CGRectMake(btn.frame.origin.x, 25, btn.frame.size.width, 5);
        }
        
        for (UIButton *b in self.arrBtns) {
            if (b.tag!=btn.tag) {
                b.selected=NO;
            }
        }
    }
    
    NSLog(@"type%d,%@",btn.tag-1000+1,btn.titleLabel.text);
    if ([self respondsToSelector:@selector(selectNewsTypeMethod:)]) {
        [self.curDelegate selectNewsTypeMethod:btn.tag-1000+1];
    }
}
#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.arrTypes count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TypeCollectionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        
    }
    NewsTypeModel *type = self.arrTypes[indexPath.row];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    title.text = type.name;
    cell.backgroundView=title;
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsTypeModel *type = self.arrTypes[indexPath.row];
    NSLog(@"click%@",type.name);
}
#pragma mark -SelectNewsTypeProtcol
- (void) selectNewsTypeMethod:(int)theType{
    
}
@end
