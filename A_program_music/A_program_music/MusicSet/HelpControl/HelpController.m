//
//  HelpController.m
//  A_program_music
//
//  Created by 姚天成 on 15/7/5.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "HelpController.h"

@interface HelpController ()
@property(nonatomic,retain)UIScrollView *myScrollView;
@property(nonatomic,retain)UIPageControl *pagC;
@end

@implementation HelpController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"about_arrow"] style:UIBarButtonItemStyleDone target:self action:@selector(backtoMain:)] autorelease];
    self.navigationItem.title = @"帮助指南";
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.myScrollView];
    self.myScrollView.contentSize = CGSizeMake(MYWIDTH * 6, 0);
    //翻页显示
    self.myScrollView.pagingEnabled = YES;
    //禁止边界反弹效果
    self.myScrollView.bounces = NO;
    //下方的滑动条
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    
    //for循环 添加图片
    for (int i = 1; i < 7; i++) {
        UIImageView *imageV = [[[UIImageView alloc] initWithFrame:CGRectMake(MYWIDTH * (i - 1), - 5, MYWIDTH + 2, MYHEIGHT - 58)]autorelease];
        NSString *string = [NSString stringWithFormat:@"jieshao%d",i];
        NSLog(@"name = %@",string);
        //NSString *name = [[NSBundle mainBundle] pathForResource:string ofType:@"png"];
        imageV.image = [UIImage imageNamed:string];
        [self.myScrollView addSubview:imageV];
        self.myScrollView.delegate = self;
    }
    
    
    
    //设置下方的小点点
    self.pagC = [[[UIPageControl alloc] initWithFrame:CGRectMake(125, 580, 150, 20)]autorelease];
    self.pagC.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pagC];
    //设置四个点点
    self.pagC.numberOfPages = 6;
    self.pagC.currentPageIndicatorTintColor = [UIColor orangeColor];//滑动到那里变成橘色
    self.pagC.pageIndicatorTintColor = [UIColor whiteColor];
    
    //点击点点  触发的方法
    [self.pagC addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    
    
}
-(void)pageAction:(UIPageControl *)page
{
    
    NSLog(@"点击下方小点点, 控制图片");
    [self.myScrollView setContentOffset:CGPointMake(MYWIDTH * self.pagC.currentPage+1, 0) animated:YES];
    
   // NSString *string = [NSString stringWithFormat:@"第%ld页",(long)self.pagC.currentPage + 1];
    //self.navigationItem.title = string;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"点击图片控制 小点点");
    self.pagC.currentPage = self.myScrollView.contentOffset.x / MYWIDTH ;
    
    //NSString *string = [NSString stringWithFormat:@"第%ld页",(long)self.pagC.currentPage + 1];
    //self.navigationItem.title = string;
    
}

-(void)backtoMain:(UIBarButtonItem *)button{

[self.sideMenuViewController presentRightMenuViewController];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
