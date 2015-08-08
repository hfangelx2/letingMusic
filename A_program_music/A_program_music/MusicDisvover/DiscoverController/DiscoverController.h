//
//  DiscoverController.h
//  A_program_music
//
//  Created by 姚天成 on 15/6/19.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "MusicViewController.h"
#import "MyScrollView.h"
#import "MusicTableViewController.h"
#import "MusicScrollView.h"
#import "DiscoverCell.h"
#import "DiscoverModel.h"
#import "DiscoverNewSongController.h"
#import "DiscoverHotList.h"


@interface DiscoverController : MusicViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSMutableArray *HeaderPicArray;

@property(nonatomic,retain)MyScrollView *scroll;
@property(nonatomic,retain)NSMutableDictionary *allDic;

@property(nonatomic,retain)MusicTableViewController *tableview;

@property(nonatomic,retain)NSMutableArray *NewSongPicArray;
@property(nonatomic,retain)MusicScrollView *scrollView;
@property(nonatomic,retain)NSMutableArray *songListPic;
@property(nonatomic,retain)NSMutableArray *otherSong;

@property(nonatomic,retain)NSMutableArray *SectionNameArray;


@end
