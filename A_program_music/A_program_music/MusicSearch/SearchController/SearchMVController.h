//
//  SearchMVController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/30.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "Connect.h"
#import "SearchDataViewCell.h"
#import "MVPlayViewController.h"

@protocol searchMvDelegate <NSObject>

-(void)hideview;

@end



@interface SearchMVController : MusicViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)id<searchMvDelegate>myDelegate;
@property(nonatomic,copy)NSString *title1;
@end
