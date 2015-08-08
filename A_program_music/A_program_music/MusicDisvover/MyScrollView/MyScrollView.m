//
//  MyScrollView.m
//
//
//  Created by yutao on 15/6/5.
//  Copyright (c) 2015年 yutao. All rights reserved.

//

#import "MyScrollView.h"

@interface MyScrollView () <UIScrollViewDelegate>

@property(nonatomic,retain)NSMutableArray *array;

@end



@implementation MyScrollView 

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.page = 1;
         self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //边框回弹取消
        self.scroll.bounces = NO;
        self.scroll.delegate = self;
        self.scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.showsVerticalScrollIndicator = NO;
        [self addSubview:_scroll];
        
    }
    return self;
}
#pragma mark -
#pragma mark 给scrollView添加图片
//为什么要建一个方法
- (void)setImages:(NSMutableArray *)names{
    self.array = [NSMutableArray arrayWithArray:names];
    NSString *first = [names firstObject];
    NSString *last = [names lastObject];
    [names insertObject:last atIndex:0];
    [names addObject:first];
    
    
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width *names.count, 0);
    
    [self createTimer];//创建定时器
    
    NSMutableArray *arr = [NSMutableArray array];
#warning mark - 以后用的时候这里需要改.遍历数组里面的对象
    for (DiscoverModel *model in names) {
        NSString *str = model.pic_url;
        [arr addObject:str];
    }
    
    int i = 0;
    NSLog(@"count = %ld",arr.count);

    for (NSString *name in arr) {

        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
        im.backgroundColor = [UIColor whiteColor];
        im.tag = 10000 + i;
        NSURL *url = [NSURL URLWithString:name];
        [im sd_setImageWithURL:url];
        im.layer.cornerRadius = 25;
        [self.scroll addSubview:im];
        _scroll.pagingEnabled= YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [im addGestureRecognizer: tap];
        im.userInteractionEnabled = YES;
        
        i++;
    }
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width, 0)];
}
#pragma mark --创建定时器
-(void)createTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                    target:self selector:@selector(timerAciton:) userInfo:nil repeats:YES];
}



#pragma mark --定时器调用的方法
- (void)timerAciton:(NSTimer *)timer{
    
    //当正常滚动的时候
    self.page ++;
    //将要到达偏移量的宽度
    CGFloat offWith = _scroll.frame.size.width *self.page;
 //   NSLog(@"with = %f",offWith);
    
//    [UIView animateWithDuration:0.5 animations:^{ //用动画也能实现,动画的偏移
        [self.scroll setContentOffset:CGPointMake(offWith, 0) animated:YES];
    //    NSLog(@"正常滚动");
//    }];
    
    
    //当不是正常滚动,滚动到边缘就取消动画
    NSInteger number = self.scroll.contentSize.width / self.scroll.frame.size.width;
    //number是当前图片个数
    if (offWith == self.scroll.frame.size.width * (number - 1)) {
        self.page = 1;
        [self.scroll setContentOffset:CGPointMake(0, 0)];
        //NSLog(@"快速跳转");
    }
   
}

#pragma mark-- 停止定时器
-(void)stopTimer
{
    if (self.myTimer) {
        
        if (self.myTimer.isValid) {//如果是开启状态
            
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
        
    }

}


#pragma mark--手指将要拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
 //   NSLog(@"timer = %@",self.myTimer);
}
#pragma mark--将要结束拖拽,也就是手指离开的时候
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self createTimer];
    
}

#pragma mark --加速结束的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    CGSize  size = scrollView.contentSize;
    CGFloat with = scrollView.frame.size.width;
    self.page = scrollView.contentOffset.x / with;
    
    //往左划,如果是滑到最后一张图
    if (scrollView.contentOffset.x == (size.width - with)) {
        
        self.page = 1;
        [scrollView setContentOffset:CGPointMake(with, 0)];
        
    }
    //往右滑,如果滑到第一张图
    if (scrollView.contentOffset.x == 0){
        
        self.page = scrollView.contentSize.width / scrollView.frame.size.width - 2 ;
        [scrollView setContentOffset:CGPointMake(size.width - with * 2, 0)];
    }
    
    
}

 
#pragma mark tapAction;
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"page = %ld",self.page);
    
    UIImageView *image = (UIImageView *)tap.view;
    NSLog(@"image = %ld",image.tag);
    
    
    return;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
