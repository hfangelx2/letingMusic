//
//  MyScrollView.h
//  
//
//  Created by yutao on 15/6/5.
//  Copyright (c) 2015年 yutao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "DiscoverModel.h"



@interface MyScrollView : UIView


- (void)setImages:(NSMutableArray *)names;
@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, assign)NSInteger page;
@property(nonatomic,retain)NSTimer *myTimer;
-(void)stopTimer;

@end
