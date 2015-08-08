//
//  VideoController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicVideoTableViewCell.h"
#import "Connect.h"
#import "MusicVideoModel.h"
#import "MVPlayViewController.h"
#import <MJRefresh.h>

@protocol MVprotocol <NSObject>

-(void)hideView;
-(void)displayView;
@end


@interface VideoController : MusicViewController<UITableViewDelegate,UITableViewDataSource,MVPLay>
@property(nonatomic,retain)NSMutableArray *bigArray;
@property(nonatomic,retain)NSMutableArray *arrayModel;
@property(nonatomic,retain)NSMutableArray *albumImgArray;
@property(nonatomic,retain)NSMutableArray *titleArray;
@property(nonatomic,retain)NSMutableArray *artistsNameArray;
@property(nonatomic,retain)NSMutableArray *posterPicArray;
@property (nonatomic, assign)id<MVprotocol>mydelegate;
@property(nonatomic,assign)NSInteger nextPage;//记录下一页
@property(nonatomic,assign)BOOL isUpLoading;//标记上拉操作还是下拉操作，yes为上拉
@property(nonatomic,assign)NSInteger pageNumber;//接口页码
@property(nonatomic,retain)NSMutableDictionary *hotDic;//接口字典
@property(nonatomic,retain)NSMutableArray *IdArray;


@end
